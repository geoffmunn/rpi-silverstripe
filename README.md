To run:

On the Raspberry Pi host:
ansible-playbook playbooks/create_silverstripe_image.yml -i inventory.ini --extra-vars "docker_container_name=runner1 docker_container_port=8081"

Known issues:

Services might not restart properly at the end - log in via docker exec -it runner2 /bin/bash and restart mysql, php7.0-fpm and nginx
service nginx start

If the install fails, you can rerun it without building the container by including --skip-tags build_container

Leave the inventory as is, the silverstripe host will be automatically populated based on the docker details

Prerequisites:
Docker
Ansible
Git

When the playbook has finished, go to http://your_rpi_address:docker_container_port/install.php

Provide the database details (username silverstripe, password silverstripe), and the admin username and password of your choice. Click 'Install SilverStripe' and wait a bit for this to complete.

After the SilverStripe installation page, you may be redirected to a index.php page (something like index.php/home/successfullyinstalled?flush=1&flushtoken=529dd4b60d96b898c6daa68a03d581c4) - this will be a 404 page, so just reload the site without the index.php.
