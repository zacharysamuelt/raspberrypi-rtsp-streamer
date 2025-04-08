# Raspberry Pi RTSP Streamer

This script turns a Raspberry Pi into a fullscreen RTSP camera viewer over HDMI.

## Usage

Run the setup script on your Pi:

```bash
curl -sSL https://raw.githubusercontent.com/zacharysamuelt/raspberrypi-rtsp-streamer/main/setup-rtsp.sh | bash

After installation, edit your RTSP URL:
nano ~/.xinitrc

Replace:
RTSP_URL="rtsp://YOUR_CAMERA_URL_HERE"

With your camera’s stream URL.

Then just reboot or run startx to launch the stream.

