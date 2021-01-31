# 6tunnel-helper
Setup a service to simply start and stop several 6tunnel ipv4 to ipv6 bindings

## Setup
1. Clone git project
```
git clone https://github.com/patrick-birkle/6tunnel-helper.git && cd 6tunnel-helper
```

2. Make `setup.sh` executable
```
chmod +x setup.sh
```

3. Start setup script
```
sudo ./setup.sh
```

## Configuration
Configure your bindings by simple add them into the config file
```
sudo vi /etc/6tunnel/config
sudo systemctl restart 6tunnel
```