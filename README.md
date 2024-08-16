# PrusaLink Docker

This repository contains a Dockerfile and associated files for running PrusaLink in a Docker container. PrusaLink is a tool for managing and controlling Prusa 3D printers.

## Prerequisites

- Docker installed on your system
- Git (optional, for cloning the repository)

## Building the Docker Image

1. Clone the repository (or download the Dockerfile):
   ```
   git clone https://github.com/donslice/prusa-link-docker.git
   cd prusa-link-docker
   ```

2. Build the Docker image:
   ```
   docker build -t prusalink .
   ```
   This command builds the Docker image and tags it as 'prusalink'.

## Running the Container

After building the image, you can run the container using Docker run or Docker Compose.

### Using Docker Run

```
docker run -it -p 8080:8080 --privileged \
  -v /opt/prusalink/config:/etc/prusalink \
  -v /opt/prusalink/data:/home/pi \
  prusalink
```

Adjust the volumes and other settings as needed for your environment.

### Using Docker Compose

1. Create a `docker-compose.yml` file with the following content:

   ```yaml
   services:
     prusalink:
       image: prusalink
       privileged: true
       ports:
         - "8080:8080"
       volumes:
         - /opt/prusalink/config:/etc/prusalink
         - /opt/prusalink/data:/home/pi
   ```

2. Run the container:
   ```
   docker-compose up -d
   ```

## Configuration

- The container is set up to use the 'pi' user by default.
- Configuration files should be placed in `/opt/prusalink/config` on the host, which is mapped to `/etc/prusalink` in the container.
- User data is stored in `/opt/prusalink/data` on the host, mapped to `/home/pi` in the container.

## Accessing PrusaLink

Once the container is running, you can access the PrusaLink web interface by navigating to `http://localhost:8080` in your web browser.

## Troubleshooting

- If you encounter permission issues, ensure that the volumes on the host have the correct permissions.
- For any PrusaLink-specific issues, refer to the [official PrusaLink documentation](https://github.com/prusa3d/Prusa-Link).

## Contributing

This repository is not actively maintained. Users are encouraged to fork the repository and make their own modifications as needed. If you develop improvements or fixes, consider sharing them with the community by creating your own public fork or repository.

## License

This Dockerfile and associated scripts are provided under the [MIT License](LICENSE).

