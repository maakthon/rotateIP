#!/bin/bash

# Check if Tor is running
if ! pgrep -x tor > /dev/null; then
    echo "[!] Tor is not running. Start it with: sudo service tor start"
    exit 1
fi

echo "[*] Starting Tor IP rotation every 10 seconds..."
echo "[*] Ensure torrc has: ControlPort 9051 and CookieAuthentication 0"

while true; do
    # Send NEWNYM signal to Tor control port to request new circuit (new IP)
    echo -e 'AUTHENTICATE ""\nSIGNAL NEWNYM\nQUIT' | nc 127.0.0.1 9051 > /dev/null

    # Show new public IP
    IP=$(torsocks curl -s https://api.ipify.org)
    echo "[+] New Tor IP: $IP"

    # Wait before rotating again
    sleep 10
done
#Maakthon

# Rotate IP with tools itself
# #!/bin/bash

# WORDLIST="words.txt"
# TARGET="http://target.onion/FUZZ"

# split -l 50 "$WORDLIST" word_chunk_

# for chunk in word_chunk_*; do
#   echo -e 'AUTHENTICATE ""\nSIGNAL NEWNYM\nQUIT' | nc 127.0.0.1 9051
#   sleep 5

#   torsocks ffuf -u "$TARGET" -w "$chunk"

#   sleep 10
# done
