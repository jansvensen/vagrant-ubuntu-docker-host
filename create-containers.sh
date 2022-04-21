# Edit max virtual memory for ELK stack (max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144])
sudo sysctl -w vm.max_map_count=262144 

# Create folder structure
sudo mkdir -p /srv

# switch to srv directory
cd /srv

# Clone repository
sudo git clone https://github.com/jansvensen/vagrant-ubuntu-docker-host.git

# switch to vagrant-ubuntu-docker-host directory
cd /vagrant-ubuntu-docker-host

# Remove existing containers
docker-compose rm --stop --force

# Pull required images
docker pull sebp/elk
docker pull splunk/splunk

docker-compose -f /srv/vagrant-ubuntu-docker-host/docker-compose.yml up -d