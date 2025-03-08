sudo apt update && sudo apt install nodejs npm
sudo npm install -g pm2

pm2 stop simple_app || true
cd SimpleApplication_DevOps_CA/

npm install

pm2 start app.js --name simple_app
