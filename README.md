# KACL
User friendly gui that you can search AWS items(instances, elbs, fqdns, network interfaces) on different accounts and regions.

Add all you wanted AWS credentials inside bash scripts as:
```
generate_list <account_name> <account-id> <default_region> <access_key> <secret_key>
```
![alt text](kacl_diagram.jpg)
```
├── cron
│   ├── crontab
│   ├── Dockerfile
│   └── scripts
│       ├── elb.sh
│       ├── eni.sh
│       ├── fqdn.sh
│       └── instance.sh
├── data
│   ├── elb.php
│   ├── eni.php
│   ├── fqdn.php
│   └── index.php
└── docker-compose.yml

```
