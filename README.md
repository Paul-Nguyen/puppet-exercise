# puppet-exercise
This deploys the puppetlabs-exercise page via nginx on port 8000.

## Assumptions
This is a vagrantbox using puppetlab's vagrantbox for puppet-installed Centos7. If you run it elsewhere, you will need to open a firewall hole - if you run firewalld on Centos7/RHEL7, this will open a hole for you in the public zone. Other linux flavours may also put their nginx directories somewhere else, so you may need to manage where the exercise page gets copied to.

We're assuming that the content to be served via 8000 TCP is not SSL-protected.

We're also assuming that the box has external access, we're using HTTPS over 443 to pull the pages in.

And another assumption is that if you're not on a Vagrant box, you don't mind it clobbering your selinux config. This is because port 8000 

## How to use it
This is meant for a vagrant setup. If you're running vagrant, just do:
> vagrant up
You should be able to view the content at http://localhost:8000.

Otherwise, the steps are:
- gem install r10k
- (for below, $PUPPET_EXERCISE is where you've pulled in this directory)
- sudo PUPPETFILE=/$PUPPET_EXERCISE/Puppetfile PUPPETFILE_DIR=/etc/puppet/modules /usr/local/bin/r10k puppetfile install
- puppet apply /$PUPPET_EXERCISE/manifests/default.pp

To deploy to different ports or directories, configure the corresponding variables at the top of manifests/default.pp.