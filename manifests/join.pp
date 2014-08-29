class realmd::join {

  $default_realm = hiera('default_realm','not-available')
  $password = hiera('password')

  exec { 'realmd':
    command => "/usr/sbin/realm join $default_realm",
    require => [Package['realmd'],File['/etc/realmd.conf'],Exec['kinit']],
  }

  exec { 'kinit':
    command => "/bin/echo $password | /usr/bin/kinit Administrator@$default_realm"
  }

}
