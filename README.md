# Tor IP Rotator - `rotateIP.sh`

🔄 Rotates your Tor IP every **10 seconds**  

---

## 🛠️ Setup Instructions

### 1. Install Tor

```bash
sudo apt update
sudo apt install tor -y
```

---

### 2. Edit Tor Configuration

Open the Tor configuration file:

```bash
sudo nano /etc/tor/torrc
```

Add or uncomment the following lines:

```
ControlPort 9051
CookieAuthentication 0
```

Then restart Tor:

```bash
sudo service tor restart
```

---

### 3. Install `torsocks`

```bash
sudo apt install torsocks -y
```

---

### 4. Run the Script

```bash
chmod +x tor-ip-rotator.sh
./tor-ip-rotator.sh
```

---

### 🔍 Test If It Works

Check your Tor-routed IP:

```bash
torsocks curl https://api.ipify.org
```

Watch the script print a new IP every 10 seconds.

---

### 💡 Tip

Change the `sleep` value in the script to rotate at a different interval:

```bash
sleep 30  # rotates every 30 seconds instead of 10
```

---
### You can now bypass IP-based restrictions when using fuzzing tools like ffuf and sqlmap by rotating your Tor IP automatically.
```bash
torsocks ffuf -u http://target.onion/FUZZ -w wordlist.txt
torsocks sqlmap -u "http://target.site/page.php?id=1" --tor --tor-type=SOCKS5 --check-tor
```
MIT licensed. Use responsibly.
