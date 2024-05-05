#!/usr/bin/env -S ruby --disable-gems

EXAMPLE {
  ## Demonstrate usage of sketch implementation
}


gemfile do
  source "https://rubygems.org"

  ## Declare gem dependencies
end

## Sketch implementation


BEGIN {
  require "tempfile"
  ENV["GEM_HOME"] = Dir.mktmpdir("rubygems-#{File.basename($PROGRAM_NAME, ".rb")}")

  require "rubygems" or abort "Invoke ruby with --disable-gems"
  require "bundler/inline"

  alias :EXAMPLE :at_exit
}
