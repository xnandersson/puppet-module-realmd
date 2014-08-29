class realmd::install {

  package { ['realmd','adcli','krb5-config','packagekit','samba-common-bin','sssd-tools','krb5-user']:
    ensure => present,
    require => Exec['krb5-config.debconf'],
  }

}
