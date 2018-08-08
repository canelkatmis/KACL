# KACL
User friendly gui that you can search AWS items(instances, elbs, fqdns, network interfaces) on multiple accounts and regions quickly.

It's really hard to find any IP, ELB or FQDN when you have lots of customer on different AWS accounts and regions. This tool will help you find it quickly!

Add all you wanted AWS credentials to bash scripts:
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
