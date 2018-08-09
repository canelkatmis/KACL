# KACL
User friendly gui that you can search AWS items(instances, elbs, fqdns, network interfaces) that are on multiple accounts and regions quickly.

It's really hard to find any IP, ELB or FQDN, when you have lots of customer on different AWS accounts and regions. This tool will help you find items quickly.

Just add all you wanted AWS credentials to bash scripts and execute docker compose(docker-compose up -d).
```
generate_list <account_name> <account-id> <default_region> <access_key> <secret_key>
```
![alt text](kacl_searchtext.gif)

High-level diagram:

![alt text](kacl_diagram.jpg)

Folder tree:
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
