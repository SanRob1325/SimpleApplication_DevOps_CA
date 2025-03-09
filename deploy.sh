set -e
echo "Start deployment"

echo "Update the system and install Node.js"
sudo dnf update -y
sudo dnf install -y nodejs npm docker

echo "Starting Docker service"
sudo systemctl start docker
sudo systemctl enable docker

echo "login Docker"
echo "$DOCKER_PASSWORD" | sudo docker login -u "$DOCKER_USERNAME" --password-stdin

echo "Stopping existing application"
sudo docker stop simple_app_container || true
sudo docker rm simple_app_container || true

echo "Pulling latest Docker container"
sudo docker pull $DOCKER_USERNAME/$IMAGE_NAME:latest

sudo docker run -d -p 8080:8080 -p 8443:8443 --name simple_app_container \
    -v $(pwd)/privatekey.pem:/app/privatekey.pem \
    -v $(pwd)/server.crt:/app/server.crt \
    $DOCKER_USERNAME/$IMAGE_NAME:latest
    
echo "Deployment successful"