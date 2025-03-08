set -e
echo "Start deployment"

echo "Update the system and install Node.js"
sudo apt update && sudo apt install nodejs 

echo "Installing PM2"
sudo npm install -g pm2

echo "Stopping existing application"
pm2 stop simple_app || true
echo "Navigating to application directory"
cd SimpleApplication_DevOps_CA/

echo "Installing dependencies"
npm install

echo "Starting application"
pm2 start app.js --name simple_app

echo "Deployment successful"