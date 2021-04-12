FROM ubuntu:20.04

# Install the dependencies
RUN dpkg --add-architecture i386 && apt-get update && \
  apt-get install -y libc6:i386 libx11-6:i386 libxext6:i386 libstdc++6:i386 libexpat1:i386 wget sudo make && \
  rm -rf /var/lib/apt/lists/*

# Download and install XC8
RUN wget -nv -O /tmp/xc8 https://ww1.microchip.com/downloads/en/DeviceDoc/xc8-v1.34-full-install-linux-installer.run && \
  chmod +x /tmp/xc8 &&  \
  /tmp/xc8 --mode unattended --unattendedmodeui none --netservername localhost --LicenseType FreeMode --prefix /opt/microchip/xc8/v1.34 && \
  rm /tmp/xc8

# Download and install MPLAB X
RUN wget -nv -O /tmp/mplabx https://ww1.microchip.com/downloads/en/DeviceDoc/MPLABX-v5.45-linux-installer.tar &&\
  cd /tmp && tar -xf /tmp/mplabx && rm /tmp/mplabx && \
  mv MPLAB*-linux-installer.sh mplabx && \
  sudo ./mplabx --nox11 -- --unattendedmodeui none --mode unattended --ipe 0 --collectInfo 0 --installdir /opt/mplabx && \
  rm mplabx

COPY build.sh /build.sh

ENTRYPOINT [ "/build.sh" ]