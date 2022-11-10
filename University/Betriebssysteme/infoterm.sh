#!/bin/bash

# read -p "Enter ssh target hostname/ip [10.10.10.52]: " target_host
# target_host=${target_host:-10.10.10.23}
# read -p "Enter username [student]: " username
# username=${username:-student}
# read -s -p "Enter password [12345]: " password
# password=${password:-12345}
# echo ""

target_host=10.10.10.23
username=student
password=12345

echo "Generating SSH keys..."
ssh-keyscan -H $target_host >> ~/.ssh/known_hosts

echo "Starting Infoterm"
if [ -z "$1" ]
then
    echo "got no starting parameters - killing firefox"
    sshpass -p $password ssh "$username"@"$target_host" "pkill -f firefox";
elif [[ $1 = -* ]]
then
    echo "got starting parameter"
    if [ "$1" = "-sound" ]; then
        echo "playing sound"
        sshpass -p $password scp $2 "$username"@"$target_host":~/sound.mp3
        sshpass -p $password ssh "$username"@"$target_host" "DISPLAY=:0 vlc --qt-start-minimized ~/sound.mp3"; ## nochmal testen wegen vlc
    elif [ "$1" = "-os" ]; then
        echo "starting web-top"

        hostname=$(hostname)
        ip=$(hostname -I)
        user=$(whoami)
        ubuntu_version=$(lsb_release -r)
        uptime=$(uptime -p) \
        space=$(df -h --output=size --total | awk "END {print}")
        free=$(df -h --output=avail --total | awk "END {print}")
        p1_name=$(ps --no-headers -eo comm --sort=-%cpu | head -1 | tail -n 1)
        p1_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -1 | tail -n 1)
        p2_name=$(ps --no-headers -eo comm --sort=-%cpu | head -2 | tail -n 1)
        p2_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -2 | tail -n 1)
        p3_name=$(ps --no-headers -eo comm --sort=-%cpu | head -3 | tail -n 1)
        p3_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -3 | tail -n 1)
        p4_name=$(ps --no-headers -eo comm --sort=-%cpu | head -4 | tail -n 1)
        p4_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -4 | tail -n 1)
        p5_name=$(ps --no-headers -eo comm --sort=-%cpu | head -5 | tail -n 1)
        p5_cpu=$(ps --no-headers -eo %cpu --sort=-%cpu | head -5 | tail -n 1)

        webtop_placeholder=$(cat <<EOF
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Webtop</title>
            </head>
            <body style="height: 100%">
                <p style="font-size: 1.9vw;">Hostname: ${hostname}</p>
                <p style="font-size: 1.9vw;">IP-Adresse: ${ip}</p>
                <p style="font-size: 1.9vw;">User: ${user}</p>
                <p style="font-size: 1.9vw;">Ubuntu Version: ${ubuntu_version}</p>
                <p style="font-size: 1.9vw;">Uptime: ${uptime}</p>
                <p style="font-size: 1.9vw;">Speicherplatz: ${space}</p>
                <p style="font-size: 1.9vw;">freier Speicherplatz: ${free}</p>
                <h1 style="font-size: 1.9vw;">Top 5 Prozesse (cpu)</h1>
                <p style="font-size: 1.9vw;">Prozess NR.1 ${p1_name}: ${p1_cpu}% CPU</p>
                <p style="font-size: 1.9vw;">Prozess NR.2 ${p2_name}: ${p2_cpu}% CPU</p>
                <p style="font-size: 1.9vw;">Prozess NR.3 ${p3_name}: ${p3_cpu}% CPU</p>
                <p style="font-size: 1.9vw;">Prozess NR.4 ${p4_name}: ${p4_cpu}% CPU</p>
                <p style="font-size: 1.9vw;">Prozess NR.5 ${p5_name}: ${p5_cpu}% CPU</p>
            </body>
            </html>
EOF
            )
        echo $webtop_placeholder > webtop.html

        sshpass -p $password scp ./webtop.html "$username"@"$target_host":~/webtop.html
        sshpass -p $password ssh "$username"@"$target_host" "DISPLAY=:0 nohup firefox --kiosk ~/webtop.html"
    fi
else
    echo "got a string for kios mode"
    content=$1

    kiosk_placeholder=$(cat << EOF
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
    echo $kiosk_placeholder > content.html
    sshpass -p $password scp ./content.html "$username"@"$target_host":~/content.html
    sshpass -p $password ssh "$username"@"$target_host" "DISPLAY=:0 nohup firefox --kiosk ~/content.html";
fi

exit 0
