# Basis-Image: Python 3.9 slim
FROM python:3.9-slim-buster

# Arbeitsverzeichnis
WORKDIR /app

# Systemabhängigkeiten installieren (für serielle Kommunikation & Bildverarbeitung)
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    git \
    libmagic1 \
    libturbojpeg0 \
    libatlas-base-dev \
    python3-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

# PrusaLink und Abhängigkeiten installieren
RUN pip install --no-cache-dir \
    git+https://github.com/prusa3d/gcode-metadata.git \
    git+https://github.com/prusa3d/Prusa-Connect-SDK-Printer.git \
    git+https://github.com/prusa3d/Prusa-Link.git

# Nutzer anlegen für Sicherheit (UID 568, entspricht deinem Beispiel)
RUN groupadd -g 568 pi && \
    useradd -m -u 568 -g 568 -s /bin/bash pi && \
    usermod -aG dialout,video pi

# Arbeitsverzeichnis Eigentümer wechseln auf pi
RUN chown -R pi:pi /app

# User wechseln
USER pi

# Port freigeben
EXPOSE 8080

# Volumes für Konfig und Daten
VOLUME /etc/prusalink
VOLUME /home/pi

# Startkommando: PrusaLink im Vordergrund mit Debug-Logging
ENTRYPOINT ["prusalink"]
CMD ["-f", "-l", "debug"]
