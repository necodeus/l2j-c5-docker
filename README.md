# L2J C5 Docker

This will help you set up a Lineage II: Chronicle V server locally using Docker. It's intended for personal use, experimentation, and learning purposes. **Please refrain from using this setup for hosting public servers without the necessary permissions and licenses.** The L2J server files may have compatibility issues with the official Chronicle V client and are intended for educational or testing purposes rather than a full gaming experience. To engage with Lineage II as it's meant to be experienced, with full support and a vibrant community, visiting the official Lineage II servers is the best approach.

# Pre-requisites

Before you begin, ensure you have the following installed on your system:

- WSL2 (Windows Subsystem for Linux 2) - required for running Linux containers on Windows through Docker Desktop
- Docker Desktop - for managing and running Docker containers

# Installation Steps

### Set Up L2J C5 Docker

Open a command line interface and run the following commands to clone the L2J C5 Docker repository and start up the Docker containers:

```bash
git clone https://github.com/necodeus/l2j-c5-docker.git
cd l2j-c5-docker
docker compose up
```

### Download and Install the C5 Client

Download the Lineage II: Chronicle V - Oath of Blood game client from one of the following sources:

```
https://l2list.com/blog/files/2303-download-lineage-2-c5-oath-of-blood-game-client.html
or
http://www.lineage2.org.uk/download/lineage-ii-the-chaotic-chronicle-chronicle-v-oath-of-blood-client/
or something else
```

### Patch the Client

Apply a patch to the game client for compatibility with the L2J server, following the instructions from:

```
https://maxcheaters.com/topic/231772-c5-system-709-original-authentication-working/
```

### Configure the Server IP

You may need to manually adjust the server IP in the l2.ini file if the game client doesn't automatically connect to your local server. Use this guide for modifying the l2.ini file:

```
https://forum.ragezone.com/threads/guide-how-to-make-your-own-l2-ini-file.118170/#post-1061866
```

Usage:

```bash
# decrypt
l2encdec.exe -d l2-original.ini l2-decrypted.ini

# encrypt
l2encdec.exe -e 413 l2-decrypted.ini l2.ini
```

### Install DirectX 9.0c

Install DirectX 9.0c to avoid potential graphical issues when playing the game:

```
https://www.filehorse.com/download-directx-9/
```

### Compatibility Settings

To ensure the game runs smoothly, set it to run in Windows XP compatibility mode. This step can help resolve issues on newer Windows versions.
