class realmd::config {

  $default_realm = hiera('default_realm','not-available')
  $kerberos_servers = hiera('kerberos_servers','not-available')
  $admin_server = hiera('admin_server','not-available')

  file {'/etc/pam.d':
    source => 'puppet:///modules/realmd/pam.d',
    recurse => true,
  }

  file {'/etc/sssd/sssd.conf':
    content => template('realmd/sssd.conf.erb'),
    require => Exec['realmd'],
  }

  file {'/etc/krb5.conf':
    content => template('realmd/krb5.conf.erb'),
    require => Package['krb5-config'],
  }

  file { '/etc/realmd.conf':
    content => template('realmd/realmd.conf.erb')
  }

  exec { 'krb5-config.debconf':
    command => '/usr/bin/debconf-set-selections /tmp/krb5-config.debconf',
    require => File['/tmp/krb5-config.debconf'],
  }

  file { '/tmp/krb5-config.debconf':
    content => template('realmd/krb5-config.debconf.erb'),
  }

}
