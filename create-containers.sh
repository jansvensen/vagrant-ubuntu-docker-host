# Create folder structure
sudo mkdir -p /srv/docker-host

# Clone repository
sudo git clone https://github.com/jansvensen/vagrant-ubuntu-hocker-host /srv/docker-host

# Remove existing containers
docker-compose rm --stop --force

# Pull required images
docker pull sebp/elk
docker pull splunk/splunk

docker-compose -f /srv/guacamole/docker-compose.yml up -d