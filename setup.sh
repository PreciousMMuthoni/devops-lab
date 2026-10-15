#!/bin/bash
set -e

# Page title: use the first word typed after the script name, or a default
PAGE_TITLE="${1:-My first automated server}"

echo "Updating package list..."
sudo apt update

echo "Installing nginx..."
sudo apt install -y nginx

echo "Writing web page..."
sudo tee /var/www/html/index.html > /dev/null <<EOF
<!DOCTYPE html>
<html>
  <head><title>$PAGE_TITLE</title></head>
  <body>
    <h1>$PAGE_TITLE</h1>
    <p>This page was created by setup.sh, not by hand.</p>
  </body>
</html>
EOF

echo "Starting nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Done! Visit: http://$(hostname -I | awk '{print $1}')"
