#encoding: utf-8
require 'rubygems'

# If you're using bundler, you will need to add this
require 'bundler/setup'

require 'sinatra'
require 'haml'
require 'data_mapper' # metagem, requires common plugins too.

# need install dm-sqlite-adapter
DataMapper.setup(:default, 'sqlite::memory:') # "sqlite3://#{Dir.pwd}/blog.db")

class Post
    include DataMapper::Resource
    property :id, Serial
    property :title, String
    property :body, Text
    property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

enable :sessions

get '/' do
	session['counter'] ||= 0
  session['counter'] += 1
  #"You've hit this page #{session['counter']} times!"
  #"Hello world, it's #{Time.now} at the server!"
  haml :index
end

get '/add' do
  Post.create(:title=>'привет и все такое')
  redirect '/list'
end

get '/list' do
	haml :list
end

get '/dog/:id' do
  # just get one dog, you might find him like this:
  @dog = Dog.find(params[:id])
  # using the params convention, you specified in your route
end
