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
    if ARGV.length == 2
        if Dir.exist?(ARGV[1])==false
            Dir.mkdir(ARGV[1]) unless File.exists?(ARGV[1])
        end
        JSON.load(response).each { |repo| %x[git -C #{ARGV[1]} clone  #{repo["git_url"]} ]}
    else
        Dir.mkdir(ARGV[0]) unless File.exists?(ARGV[0])
        JSON.load(response).each { |repo| %x[git -C #{ARGV[0]} clone  #{repo["git_url"]} ]}
    end
end