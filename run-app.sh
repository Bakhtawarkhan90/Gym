# Downloading Docker and Docker Compose

echo "****************************** Installing Docker and Docker Compose **************************"
sudo apt update && sudo apt-get install -y docker.io
sudo apt-get install docker-compose-v2
# Adding the currently logged-in user and Jenkins user to the Docker group
echo "****************************** Adding users to Docker group **************************"
sudo chown $USER /var/run/docker.sock
sudo usermod -aG docker $USER && sudo apt update  -y

echo "**************************DOCKER VERSION***************************"
sudo docker --version
echo "*********************DOCKER-COMPOSE VERSION*************************"
sudo docker compose version


echo "**************************RUNNING PROJECT*************************** "
cd /home/ubuntu/Gym
docker compose down
docker compose up --build -d

echo "**************************NOW YOU CAN ACCESS APP ON PORT 5000 *************************** "
