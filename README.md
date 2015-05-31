# puppet-exercise
This deploys the puppetlabs-exercise page via nginx on port 8000. It works with vagrant.

## Assumptions
This has been setup using puppetlab's vagrantbox for puppet-installed Centos7. If you run firewalld on Centos7/RHEL7, this will open a hole for you in the public zone. If you run it elsewhere, you will need to open a firewall hole.

Non-redhat linux flavours may put their nginx directories somewhere else, so you may need to manage where the exercise page gets copied to (see how to customize it below).

We're assuming that the content to be served via 8000 TCP is not SSL-protected.

We're also assuming that the box has external access to the internet (to grab the exercise repo and puppet modules), we're using HTTPS over 443 to pull the pages in.

And another assumption is that if you're not on a Vagrant box, you don't mind it clobbering your selinux config. This is because port 8000 is used by a sound device and we may not want to overwrite the config to enable that port in selinux for the web context, so this code will set your selinux permissions to permissive. There are a range of unused ports where we could have applied a selinux context to the port, but that's what we've got here.

## How to use it
This is meant for a vagrant setup. If you're running vagrant, just clone/export this archive on your computer, and:
> vagrant up

You should be able to view the content at http://localhost:8000.

Otherwise, the steps (on a box with puppet installed) are:
- gem install r10k
- (for below, $PUPPET_EXERCISE is where you've pulled in this directory)
- sudo PUPPETFILE=/$PUPPET_EXERCISE/Puppetfile PUPPETFILE_DIR=/etc/puppet/modules /usr/local/bin/r10k puppetfile install
- puppet apply /$PUPPET_EXERCISE/manifests/default.pp

To deploy to different ports or directories, configure the corresponding variables at the top of manifests/default.pp.

## How to customise it
Three basic configuration options are available for tweaking:
>$webpage_root  = '/usr/share/nginx/html/puppet-exercise'
>$exercise_port = 8000
>$exercise_src  = 'https://github.com/puppetlabs/exercise-webpage.git'

'''$webpage_root''' may be tweaked depending on your preferred directory for deployment.

'''$exercise_port''' is set to 8000 for the sake of this exercise.

'''$exercise_src''' is set to the https URL of the specified page. SSH outside of some organisations is blocked so git:// is less likely to work out of the box.
