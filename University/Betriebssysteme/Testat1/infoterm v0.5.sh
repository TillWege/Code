#!/bin/bash

webtop_placeholder = $(cat << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Webtop</title>
</head>
<body>
    <p>Hostname: ${hostname}</p>
    <p>IP-Adresse: ${ip}</p>
    <p>Ubuntu Version: ${ubuntu_version}</p>
    <p>Uptime: ${uptime}</p>
    <p>Speicherplatz: ${space}</p>
    <p>freier Speicherplatz: ${free}</p>
    <hr>
    <h1>Top 5 Prozesse (cpu)</h1>
    <p>Prozess NR.1 ${p1_name}: ${p1_cpu}% CPU</p>
    <p>Prozess NR.2 ${p2_name}: ${p2_cpu}% CPU</p>
    <p>Prozess NR.3 ${p3_name}: ${p3_cpu}% CPU</p>
    <p>Prozess NR.4 ${p4_name}: ${p4_cpu}% CPU</p>
    <p>Prozess NR.5 ${p5_name}: ${p5_cpu}% CPU</p>
</body>
</html>
EOF
)

kiosk_placeholder = $(cat << EOF
<!DOCTYPE html>
<html lang="en" style="height: 100%;">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kiosk</title>
</head>
<body style="height: 100%">
    <div style="display: flex; align-items: center; justify-content: center; height:100%; font-size: 100px">
        <h1>${content}</h1>
    </div>
</body>
</html>
EOF
)



exit;

if [ -z "$1" ]
then
    echo "got no starting params - killing firefox"
    sshpass -p "testpassword" ssh tillwege@192.168.64.2 "pkill -f firefox";
elif [[ $1 = -* ]]
then
    echo "got starting parameter"
    if [ "$1" = "-sound" ]; then
        echo "playing sound"
        sshpass -p "testpassword" scp $2 tillwege@192.168.64.2:~/sound.mp3
        sshpass -p "testpassword" ssh tillwege@192.168.64.2 "DISPLAY=:0 vlc --qt-start-minimized ~/sound.mp3"; ## nochmal testen wegen vlc
    elif [ "$1" = "-osremote" ]; then
        echo "starting web-top (remote)"
        sshpass -p "testpassword" scp webtop_placeholder.html tillwege@192.168.64.2:~/webtop_placeholder.html
        sshpass -p "testpassword" ssh tillwege@192.168.64.2 'hostname=$(hostname) \
                                                            ip=$(hostname -I) \
                                                            ubuntu_version=$(lsb_release -r) \
                                                            uptime=$(uptime -p) \
                                                            space=$(df -h --output=size --total | awk "END {print $1}") \
                                                            free=$(df -h --output=avail --total | awk "END {print $1}") \
                                                            p1_name=$(ps --no-headers -eo comm --sort=-%cpu | head -1 | tail -n 1) \
                                                            p1_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -1 | tail -n 1) \
                                                            p2_name=$(ps --no-headers -eo comm --sort=-%cpu | head -2 | tail -n 1) \
                                                            p2_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -2 | tail -n 1) \
                                                            p3_name=$(ps --no-headers -eo comm --sort=-%cpu | head -3 | tail -n 1) \
                                                            p3_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -3 | tail -n 1) \
                                                            p4_name=$(ps --no-headers -eo comm --sort=-%cpu | head -4 | tail -n 1) \
                                                            p4_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -4 | tail -n 1) \
                                                            p5_name=$(ps --no-headers -eo comm --sort=-%cpu | head -5 | tail -n 1) \
                                                            p5_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -5 | tail -n 1) \
                                                            envsubst < webtop_placeholder.html > webtop.html; \
                                                            DISPLAY=:0 nohup firefox --kiosk ~/webtop.html'

    elif [ "$1" = "-os" ]; then
    echo "starting web-top (local)"
    export infoterm_hostname=$(hostname)
    export infoterm_ip=$(hostname -I)
    export infoterm_ubuntu_version=$(lsb_release -r)
    export infoterm_uptime=$(uptime -p) \
    export infoterm_space=$(df -h --output=size --total | awk "END {print $1}")
    export infoterm_free=$(df -h --output=avail --total | awk "END {print $1}")
    export infoterm_p1_name=$(ps --no-headers -eo comm --sort=-%cpu | head -1 | tail -n 1)
    export infoterm_p1_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -1 | tail -n 1)
    export infoterm_p2_name=$(ps --no-headers -eo comm --sort=-%cpu | head -2 | tail -n 1)
    export infoterm_p2_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -2 | tail -n 1)
    export infoterm_p3_name=$(ps --no-headers -eo comm --sort=-%cpu | head -3 | tail -n 1)
    export infoterm_p3_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -3 | tail -n 1)
    export infoterm_p4_name=$(ps --no-headers -eo comm --sort=-%cpu | head -4 | tail -n 1)
    export infoterm_p4_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -4 | tail -n 1)
    export infoterm_p5_name=$(ps --no-headers -eo comm --sort=-%cpu | head -5 | tail -n 1)
    export infoterm_p5_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -5 | tail -n 1)
    envsubst < webtop_placeholder.html > webtop.html

    sshpass -p "testpassword" scp webtop.html tillwege@192.168.64.2:~/webtop.html
    sshpass -p "testpassword" ssh tillwege@192.168.64.2 "DISPLAY=:0 nohup firefox --kiosk ~/webtop.html"
    fi
else
    echo "got a string for kios mode"
    sed -e "s/\${content}/$1/" html_placeholder.html > content.html
    sshpass -p "testpassword" scp ./content.html tillwege@192.168.64.2:~/content.html
    sshpass -p "testpassword" ssh tillwege@192.168.64.2 "DISPLAY=:0 nohup firefox --kiosk ~/content.html";
fi

exit 0