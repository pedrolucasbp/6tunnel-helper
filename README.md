# tunnel6-helper  
Setup a service to simply start and stop several 6tunnel ipv4 to ipv6 bindings  

I modified this software to be installed and configured through Ansible.
But below are steps for a manual installation.  

## Setup  
Configure your bindings by copy the sample to a service configuration file and modify the indicated fields:
```
sudo git clone https://github.com/pedrolucasbp/tunnel6-helper.git /etc/tunnel6-helper
sudo cp /etc/tunnel6-helper/conf.d/config.conf-sample /etc/tunnel6-helper/conf.d/config.conf-sample
sudo vim /etc/tunnel6-helper/conf.d/service-sample.conf
sudo ln -s /etc/tunnel6-helper/tunnel6-helper.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl restart tunnel6-helper.service
```

## Original Author  
Patrick Birkle - https://github.com/pbirkle  
https://github.com/pbirkle/6tunnel-helper
