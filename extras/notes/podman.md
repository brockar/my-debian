# From Docker to Podman

In this guide, we'll explore how to transition from Docker to Podman with your existing Docker and Docker Compose setups.
While the steps are straightforward, a few adjustments are still required, as a seamless switch is not yet fully supported.  

## Installation

You can install Podman and Podman Compose with your package manager.  
For example, on Debian/Ubuntu:

```bash
sudo apt install podman podman-compose -y
```

## Containers on lower ports

To allow rootless Podman containers to bind to ports below 1024, modify the following system parameter:

```bash
sudo sysctl net.ipv4.ip_unprivileged_port_start=80
```

This command lowers the unprivileged port range, enabling the use of lower ports like 80 without root privileges.

## Containers from [docker.io](https://hub.docker.com)

To ensure Podman pulls images from Docker Hub (docker.io), update the container registries configuration:

```bash
sudo vim /etc/containers/registries.conf
```

Look for `unqualified-search-registries` and add `docker.io`

```bash
unqualified-search-registries = ["docker.io"]
```

## Switching from Docker to Podman

### Volumes

Keep in mind that depending on how you have configured your volumes, you might need to create backups.  
If your volumes are managed by Docker, make sure to back them up before transitioning. You can find instructions on how to back up Docker volumes [here](https://docs.docker.com/engine/storage/volumes/#back-up-restore-or-migrate-data-volumes).  
If your volumes are stored on system paths, there’s nothing you need to do—everything will work as expected without any additional steps.  

### Docker compose

For each `compose.yml` file, you'll need to stop the containers using:

```bash
docker compose down
```

Then, recreate them with Podman:

```bash
podman-compose up -d
```

### Docker run

For individual containers running with `docker run`, follow these steps:
Stop the container:

```bash
docker stop container_name
```

Remove the container:

```bash
docker rm container_name
```

Then, you can recreate them using Podman.

```bash
podman run container_name ...
```

## Alias

You can also create an alias for Docker to Podman, so every time you use the `docker` ommand, it automatically calls Podman.  
To do this, add the following alias to your shell configuration file (e.g., `.bashrc`, `.zshrc`):

```bash
alias docker=podman
```

This will ensure that any `docker` commands you run will use `podman` instead.
