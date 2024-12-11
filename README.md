# Dockerized Swizzin and Joal

This repository provides a Dockerized setup for running **Swizzin**, a seedbox management suite, and **Joal (Just Another Leecher)**, a lightweight torrent seeder tool. This setup simplifies deployment and ensures a consistent environment for both services.

---

## Features

### Swizzin

see docs : https://swizzin.ltd/getting-started

- Manage seedbox services like Deluge, qBittorrent, Plex, and more.
- Web-based user panel for controlling installed applications.
- Easy management of torrents, users, and system updates.

### Joal
- A lightweight, customizable seeding tool.
- Fakes upload statistics for torrents.
- Includes a web UI for easy configuration.

---

## Requirements

- Docker (version 20.10 or newer)
- Docker Compose (version 1.29 or newer)

---

## Project Structure
```
└── 📁seedbox
    └── 📁joal
        └── 📁clients
        └── 📁torrents
            └── 📁archived
        └── config.json
    └── docker-compose.yml
    └── Dockerfile
    └── README.md
    └── startup.sh
```

## Setup

### 1. Clone the Repository
```bash
git clone https://github.com/valentinmaxime/dockerised-swzzin.git
cd docker-swizzin-joal
```


### 2. Configure Environment Variables

Edit the `startup.sh` file to set up necessary configurations for swizzin :

```bash
# Swizzin Settings
SWIZZIN_USER=seedbox
SWIZZIN_PASS=securepassword
```

### 3. Edit swizzin startup script (optional)
Edit the `startup.sh` file to set up the applications you want in swizzin :
```bash
bash <(curl -sL git.io/swizzin) --unattend nginx panel deluge btsync radarr lidarr --user $SEEDBOX_USER --pass $SEEDBOX_PASS
```

**Note** :  The order of packages is important (see https://swizzin.ltd/guides/advanced-setup).

Edit the `docker-compose.yml` file to set up necessary configurations for joal (prefix and secret token) :

```bash
# Joal Settings
command: ["--joal-conf=/data", "--spring.main.web-environment=true", "--server.port=8003", "--joal.ui.path.prefix=OP", "--joal.ui.secret-token=SC"]
```

Edit the `config.json` file to set up necessary configurations for joal
```json
"minUploadRate" : 30,
"maxUploadRate" : 308,
"simultaneousSeed" : 5,
"client" : "utorrent-3.5.0_43916.client",
"keepTorrentWithZeroLeechers" : true
```



### 4. Build swizzin docker image
```bash
docker build -t swizzin .
```


### 5. Build and Start the Services

Use Docker Compose to build and start the services:

```bash
docker-compose up -d
```

This will:
- Launch Swizzin in a container.
- Launch Joal alongside it.

### 4. Access the Services

- **Swizzin Web Panel**: [http://your-server-ip](http://your-server-ip)
![image](swizzin.PNG)
- **Joal Web UI**: [http://your-server-ip/OP/ui:8003](http://your-server-ip/OP/ui:8003)
**To configure joal ui, click on `change connection settings` button and click on save.**
![image](joal_conf.PNG)


---

## Customization

### Swizzin Configuration
Swizzin can be customized to include additional services like qBittorrent, Plex, or Deluge. Modify the Swizzin installation script in `Dockerfile` or extend the Swizzin configuration via the web panel.

### Joal Configuration
1. Use the `JOAL_CONFIG_URL` environment variable to specify a custom `joal-config.json`.
2. Place the `joal-config.json` file in `./data/joal` for direct customization.

Example `joal-config.json`:
```json
{
  "minUploadRate": 50,
  "maxUploadRate": 1000,
  "files": ["/data/torrents"]
}
```

---

## Security Recommendations

- Use strong passwords for the Swizzin panel.
- Secure the Joal `SECRET` to prevent unauthorized access.
- Use a reverse proxy (e.g., NGINX or Traefik) to enable HTTPS for secure communication.

---

## Improvements / Future Updates

### Planned Enhancements
- **Settings**: Add some Joal Settings in configurable env variables.
- **Network**: Add VPN integration.
- **Docker**: Change ubuntu to debian.
- **SSL Integration**: Automate HTTPS setup using Let's Encrypt or other SSL providers.
- **Improved Documentation**: Provide more detailed usage examples and FAQs.
- **Multi-User Support**: Enhance Swizzin configuration to better support multiple users with isolated environments.
- **CI/CD Pipelines**: Automate build and deployment processes with GitHub Actions or similar tools.

---

### Community Contributions
- I welcome contributions to extend functionality or fix issues.
- Please open a pull request or issue for discussions.

---


## Contributing

Feel free to open issues or submit pull requests to improve this setup.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.















