class parameterized::one ($filename) {
  file { $filename: }
}

class parameterized::two ($filename) {
  file { $filename: }
}

class parameterized::three ($include_file) {
  if $include_file == true {
    file { "foo": }
  }
}
