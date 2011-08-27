class aliased {
  file { 'foo':
    require => File['bar']
  }

  file { 'baz':
    alias => 'bar'
  }
}

class alias_array {
  file { 'foo':
    require => [File['bar'], File['baz']]
  }

  file { 'bam':
    alias => ['bar', 'baz']
  }
}
