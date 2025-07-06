# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory in the container
WORKDIR /usr/src/app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    libcap-dev \
    libmagic1 \
    libturbojpeg0 \
    libatlas-base-dev \
    python3-numpy \
    libffi-dev \
    gcc \
    python3-dev \
    screen \
    systemd \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    git+https://github.com/prusa3d/gcode-metadata.git \
    git+https://github.com/prusa3d/Prusa-Connect-SDK-Printer.git \
    git+https://github.com/prusa3d/Prusa-Link.git

# Create user 'pi' with UID and GID 568
RUN groupadd -g 568 pi \
    && useradd -m -u 568 -g 568 -s /bin/bash pi

# Add 'pi' to additional groups
RUN usermod -a -G dialout pi \
    && usermod -a -G video pi

# Set permissions for working directory
RUN chown -R pi:pi /usr/src/app

# Use the non-root user
USER pi

EXPOSE 8080

VOLUME /home/pi
VOLUME /etc/prusalink

ENTRYPOINT ["prusalink"]
CMD ["-f"]