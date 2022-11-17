DATEI="test.txt"
if [ -f "$DATEI" ]; then
    echo "$DATEI exists."
else 
    echo "$DATEI does not exist."
fi
