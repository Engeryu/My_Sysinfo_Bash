# 🖥️ System Information Toolkit (Bash)

A simple, interactive Bash script to display essential system information across hardware, network, and processes.

---

## 🚀 Features

- 🔧 **Hardware Info**

  - CPU, RAM, Disks, Motherboard, BIOS, GPU, Kernel version
- 🌐 **Network Tools**

  - Ping, Traceroute, IP configuration, Netstat, UFW status
- ⚙️ **Process Management**

  - List, monitor, and kill processes
- 🖌️ **User-Friendly Interface**

  - Colored menus
  - Pause prompts for clarity
  - Input validation
  - Command checks for robustness

---

## 🛠️ Requirements

- Bash (`#!/bin/bash`)
- Utilities used to download to run every options:
  - `lscpu`, `free`, `df`, `smartctl`, `dmidecode`, `lspci`, `glxinfo`
  - `ip`, `traceroute`, `netstat`, `ufw`, `top`, `ps`, `kill`

> Some features (like BIOS info) require `sudo`.

---

## 📦 Installation

```bash
git clone https://github.com/your_username/system-info-bash.git
cd system-info-bash
chmod +x system_info.sh
./system_info.sh
```

## 🖥️ Main menu style

## ==============================================

    System Information

1) Hardware Information
2) Network Information
3) Process Management
4) Exit

## ==============================================

## 🤝 Contributions

Contributions are welcome! Feel free to fork and improve.
