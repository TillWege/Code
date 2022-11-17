#!/bin/bash

html=$(cat << EOF
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
        <h1>$1</h1>
    </div>
</body>
</html>
EOF
)
echo "running"
echo $html > /usr/local/apache2/htdocs/index.html
httpd-foreground