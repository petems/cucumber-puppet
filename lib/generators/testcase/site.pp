class test {
  file { "foo":
    alias => [ "bar", "baz" ],
    ensure => present,
  }

  # ensure aliases are expanded
  file { "foo2":
    require => File["bar"],
    ensure => present,
  }
}

class parameterized($include_foo=false) {
  if $include_foo == true {
    file { "foo": }
  }
}
