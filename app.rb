require 'sinatra'
require 'json'

get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/:domain/:type.json' do
  output = %x[dig +short #{domain} #{type}]
  records = output.split("\n")
  content_type :json
  records.to_json
end

get '/:domain/:type.txt' do
  output = %x[dig +short #{domain} #{type}]
  content_type :txt
  output
end


def domain
  params[:domain].gsub(/[^a-zA-Z1-9.+-]/, '')
end

def type
  params[:type].gsub(/[^a-zA-Z]/, '').capitalize
end