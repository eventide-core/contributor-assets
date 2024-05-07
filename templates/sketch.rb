#!/usr/bin/env -S ruby --disable-gems

require "tempfile"
ENV["GEM_HOME"] = Dir.mktmpdir("rubygems-#{File.basename($PROGRAM_NAME, ".rb")}")

require "rubygems" or abort "Invoke ruby with --disable-gems"
require "bundler/inline"

gemfile do
  source "https://rubygems.org"

  ## Declare gem dependencies
end

## Sketch implementation


## Demonstrate usage of sketch implementation
