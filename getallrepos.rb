require 'net/http'
require 'json'

unless ARGV.length == 1
    puts "Enter gihtub username in the command line."
end
url = 'https://api.github.com/users/'+ARGV[0]+'/repos'
uri = URI(url)
response = Net::HTTP.get(uri)
# puts JSON.parse(response)
JSON.load(response).each { |repo| %x[git clone #{repo["git_url"]} ]}