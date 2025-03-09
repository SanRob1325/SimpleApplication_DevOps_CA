set -e
echo "Start deployment"

echo "Update the system and install Node.js"
sudo dnf update -y
sudo dnf install -y nodejs npm

echo "Installing PM2"
sudo npm install -g pm2

echo "Stopping existing application"
pm2 stop simple_app || true

echo "Installing dependencies"
npm install

echo "Starting application"
pm2 start ./bin/www --name simple_app

echo "Deployment successful"