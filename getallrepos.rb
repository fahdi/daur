require 'net/http'
require 'json'
 
url = 'https://api.github.com/users/fahdi/repos'
uri = URI(url)
response = Net::HTTP.get(uri)
# puts JSON.parse(response)
JSON.load(response).each { |repo| %x[git clone #{repo["git_url"]} ]}