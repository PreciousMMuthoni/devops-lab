#!/bin/bash
set -e

echo "Updating package list..."
sudo apt update

echo "Installing nginx..."
sudo apt install -y nginx

echo "Writing web page..."
sudo tee /var/www/html/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html>
  <head><title>My first automated server</title></head>
  <body>
     <h1>Hello from my automated server!</h1>
     <p>This page was created by setup.sh, not by hand. I am very proud!</p>
  </body>
</html>
EOF

echo "Starting nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx

echo "Done! Visit: http://$(hostname -I | awk '{print $1}')"
