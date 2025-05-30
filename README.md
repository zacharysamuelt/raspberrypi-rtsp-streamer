# Raspberry Pi RTSP Streamer

This script turns a Raspberry Pi into a fullscreen RTSP camera viewer over HDMI. It was designed to use a SINGLE stream to directly output a stream over HDMI at 1080p. I had a bunch of Raspberry Pi's sitting around that I wanted to repurpose for security monitoring.

## Usage

Run the setup script on your Pi:

```bash
curl -sSL https://raw.githubusercontent.com/zacharysamuelt/raspberrypi-rtsp-streamer/main/setup-rtsp.sh | bash
```
After installation, edit your RTSP URL:

```bash
nano ~/.xinitrc
```

Replace:
```bash
RTSP_URL="rtsp://YOUR_CAMERA_URL_HERE"
```

With your camera’s stream URL.

Then just reboot or run ```startx``` to launch the stream.

