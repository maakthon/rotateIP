#!/bin/bash

#############################################
# Tor IP Rotator - tor-ip-rotator.sh
#
# 🔄 Rotates your Tor IP every 10 seconds.
# ✅ Useful for testing, scraping, and avoiding rate limits.
#
# 🛠️ Setup Instructions:
#
# 1. Install Tor:
#    sudo apt update
#    sudo apt install tor -y
#
# 2. Edit Tor config:
#    sudo nano /etc/tor/torrc
#    Add or uncomment:
#       ControlPort 9051
#       CookieAuthentication 0
#
#    Then restart Tor:
#       sudo service tor restart
#
# 3. Install torsocks:
#    sudo apt install torsocks -y
#
# 4. Run this script:
#    chmod +x tor-ip-rotator.sh
#    ./tor-ip-rotator.sh
#
# 🔍 To test:
#    torsocks curl https://api.ipify.org
#
# 💡 Tip:
#    Change the `sleep` value for a different rotation interval.
#############################################

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
