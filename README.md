# Overview
This is an Ansible playbook which will build a docker container containing a nearly-finished Silverstripe installation.
It will configure and install Nginx, PHP 7.0 and MySQL, and then download SilverStripe 3.7.

This container is NOT designed for production purposes, and is specifically built for Raspberry Pi 2+ and 3+ units.

## Supported versions
The following versions are supported:

- SilverStripe 3.7
- PHP 7.0
- Nginx 1.10.3
- Docker 18.06.0-ce
- Rasbpian Stretch
- Ansible 2.6.2
- Git 2.11.0

### Configuration requirements
The playbook is designed to be run as 'localhost' on the target RPi. The inventory file should not need to be changed, and is dynamically updated based on the container that is created.

### Users
The playbook will create an 'ansible' user (password 'ansible') in the container - for automation purposes - and a 'silverstripe' user in MySQL (password 'silverstripe').

## Playbook variables

The playbook supports two user-defined variables - the container name and the port.
If you are running multiple containers, then you should change these on a per-install basis, using extra-vars (see examples below).

```yml
  vars:
    docker_container_name: silverstripe
    docker_container_port: 8080
```

# Example playbook
The playbook is fully self-contained and does not require any customisation.
A standard playbook command looks like this:

```bash
ansible-playbook ./playbooks/create_silverstripe_image.yml -i inventory
```

If you want to use different names or ports for the container, then run the playbook like this:

```bash
ansible-playbook ./playbooks/create_silverstripe_image.yml -i inventory -extra-vars "docker_container_name=silverstripe2 docker_container_port=8081"
```

# Post-execution steps
When the playbook has finished, go to http://your_rpi_address:docker_container_port/install.php

Provide the database details (username silverstripe, password silverstripe), and the admin username and password of your choice. Click 'Install SilverStripe' and wait a bit for this to complete.

After the SilverStripe installation page, you may be redirected to a index.php page (something like index.php/home/successfullyinstalled?flush=1&flushtoken=529dd4b60d96b898c6daa68a03d581c4) - this will be a 404 page, so just reload the site without the index.php.

# Recent changes
First release, everything looks good.

# Known issues
Services might not restart properly at the end - to start them manually you should log in via docker:

```bash
exec -it DOCKER_CONTAINER_NAME /bin/bash
service nginx start
service php7.0-fpm start
service mysql start
```

If the install fails for an Ansible-related reason, you can rerun it without building the container by including `--skip-tags build_container`.

# Contact information

geoff@zimoobo.com
