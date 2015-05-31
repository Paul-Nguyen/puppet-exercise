$webpage_root  = '/usr/share/nginx/html/puppet-exercise'
$exercise_port = 8000
$exercise_src  = 'https://github.com/puppetlabs/exercise-webpage.git'

class { 'nginx': }
class { 'git': }

#selinux::port { 'nginx-port':
#    port     => $exercise_port,
#    context  => 'http_port_t',
#    protocol => 'tcp',
#} ->
if ($selinux) {
    class { 'selinux':
        mode   => 'permissive',
        before => Nginx::Resource::Vhost['puppet-nginxercise'],
    }
}

nginx::resource::vhost { 'puppet-nginxercise':
    ensure      => present,
    server_name => ['puppet-exercise'],
    www_root    => $webpage_root,
    listen_port => $exercise_port,
} ->
vcsrepo { $webpage_root:
    ensure   => latest,
    provider => git,
    source   => $exercise_src,
    revision => 'master',
}

firewalld_rich_rule { 'puppet exercise public port':
    ensure => present,
    zone   => 'public',
    port   => {
                protocol => tcp,
                port     => $exercise_port,
              },
    action => 'accept',
}
