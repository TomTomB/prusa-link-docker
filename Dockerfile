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
    systemd \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir \
    git+https://github.com/prusa3d/gcode-metadata.git \
    git+https://github.com/prusa3d/Prusa-Connect-SDK-Printer.git \
    git+https://github.com/prusa3d/Prusa-Link.git

RUN useradd -m pi && echo "pi:raspberry" | chpasswd && adduser pi sudo

RUN chown -R pi:pi /usr/src/app

RUN usermod -a -G dialout pi

RUN usermod -a -G video pi

USER pi

EXPOSE 8080

VOLUME /home/pi
VOLUME /etc/prusalink

ENTRYPOINT ["prusalink"]
CMD ["-f"]
