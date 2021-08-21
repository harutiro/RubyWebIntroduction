require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models/contribution.rb'

before do


end

get '/' do
    @contributions = Contribution.all
    @categories = Category.all
    erb :index
end
