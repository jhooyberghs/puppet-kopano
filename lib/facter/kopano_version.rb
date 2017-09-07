#!/usr/bin/ruby
require 'facter'

version = Facter::Util::Resolution.exec("kopano-server -V | cut -f 2 -d ' '")

Facter.add("kopano_version") do
  setcode do
    version
  end
end
