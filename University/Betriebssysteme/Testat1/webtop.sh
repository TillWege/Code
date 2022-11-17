#!/bin/bash

# -e "s/\${}/$var/" \

`sed -e "s/\${hostname}/$(hostname)/" \
    -e "s/\${}/$(hostname -I)/" \
    -e "s/\${ubuntu_version}/$(lsb_release -r)/" \
    -e "s/\${uptime}/$(uptime | awk -F'( |,|:)+' '{print $6,$7",",$8,"hours,",$9,"minutes."}')/" \
    -e "s/\${space}/$(df -h --output=size --total | awk 'END {print $1}')/" \
    -e "s/\${free_space}/$(df -h --output=avail --output=size --total | awk 'END {print $1}')/" \
    -e "s/\${p1_name}/"$(ps --no-headers -eo comm --sort=-%cpu | head -1 | tail -n 1)"/"\
    -e "s/\${p1_cpu}/"$(ps --no-headers -eo %cpu --sort=-%cpu | head -1 | tail -n 1 | xargs)"/"\
    -e "s/\${p2_name}/"$(ps --no-headers -eo comm --sort=-%cpu | head -2 | tail -n 1)"/"\
    -e "s/\${p2_cpu}/"$(ps --no-headers -eo %cpu --sort=-%cpu | head -2 | tail -n 1 | xargs)"/"\
    -e "s/\${p3_name}/"$(ps --no-headers -eo comm --sort=-%cpu | head -3 | tail -n 1)"/"\
    -e "s/\${p3_cpu}/"$(ps --no-headers -eo %cpu --sort=-%cpu | head -3 | tail -n 1 | xargs)"/"\
    -e "s/\${p4_name}/"$(ps --no-headers -eo comm --sort=-%cpu | head -4 | tail -n 1)"/"\
    -e "s/\${p4_cpu}/"$(ps --no-headers -eo %cpu --sort=-%cpu | head -4 | tail -n 1 | xargs)"/"\
    -e "s/\${p5_name}/"$(ps --no-headers -eo comm --sort=-%cpu | head -5 | tail -n 1)"/"\
    -e "s/\${p5_cpu}/"$(ps --no-headers -eo %cpu --sort=-%cpu | head -5 | tail -n 1 | xargs)"/"\
    webtop_placeholder.html > webtop.html;`