#!/usr/bin/ruby
require 'net/http'
require 'json'

unless ARGV.length >= 1
    puts "\tusage: getallrepos.rn [username] [directory]"
    raise ArgumentError, "enter github username in the command line."
else
    url = 'https://api.github.com/users/'+ARGV[0]+'/repos'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.load(response).each { |repo| %x[git clone #{repo["git_url"]} ]}
end