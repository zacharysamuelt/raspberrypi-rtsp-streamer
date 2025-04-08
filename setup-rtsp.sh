#!/bin/bash

# === 1. Update system ===
sudo apt update && sudo apt upgrade -y

# === 2. Force HDMI output & resolution ===
sudo sed -i '/^#*hdmi_force_hotplug/d' /boot/firmware/config.txt
sudo sed -i '/^#*hdmi_group/d' /boot/firmware/config.txt
sudo sed -i '/^#*hdmi_mode/d' /boot/firmware/config.txt
sudo sed -i '/^#*config_hdmi_boost/d' /boot/firmware/config.txt

echo "hdmi_force_hotplug=1" | sudo tee -a /boot/firmware/config.txt
echo "hdmi_group=1" | sudo tee -a /boot/firmware/config.txt
echo "hdmi_mode=82" | sudo tee -a /boot/firmware/config.txt   # 1080p
echo "config_hdmi_boost=7" | sudo tee -a /boot/firmware/config.txt

# === 3. Install lightweight X server and ffmpeg ===
sudo apt install --no-install-recommends xserver-xorg xinit openbox ffmpeg -y

# === 4. Create .xinitrc with placeholder RTSP stream ===
cat <<EOF > ~/.xinitrc
#!/bin/bash

# Replace the RTSP_URL below with your own stream.
RTSP_URL="rtsp://YOUR_CAMERA_URL_HERE"

if [[ "\$RTSP_URL" == "rtsp://YOUR_CAMERA_URL_HERE" ]]; then
  echo "❌ Please edit ~/.xinitrc and set your RTSP stream URL before using startx."
  sleep 5
  exit 1
fi

ffplay -fs -noborder -an -fflags nobuffer -flags low_delay "\$RTSP_URL" > ~/ffplay.log 2>&1
EOF

chmod +x ~/.xinitrc

# === 5. Enable console auto-login ===
sudo raspi-config nonint do_boot_behaviour B2

# === 6. Add startx to bashrc only for TTY1 ===
if ! grep -q 'startx' ~/.bashrc; then
  echo '' >> ~/.bashrc
  echo 'if [ "\$(tty)" = "/dev/tty1" ]; then' >> ~/.bashrc
  echo '  startx' >> ~/.bashrc
  echo 'fi' >> ~/.bashrc
fi

echo ""
echo "✅ Setup complete!"
echo "👉 To finish setup, edit ~/.xinitrc and paste in your RTSP stream URL."
echo ""
echo "Rebooting in 5 seconds..."
sleep 5
sudo reboot

