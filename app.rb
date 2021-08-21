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

post '/create' do
    # img_url = ''
    # if params[:file]
    #     img = params[:file]
    #     tempfile = img[:tempfile]
    #     upload = Cloudinary::Uploader.upload(tempfile.path)
    #     img_url = upload['url']
    # end
    
    Contribution.create({
        main_title: params[:main_title],
        sub_title: params[:sub_title],
        user_name: params[:user_name],
        winos: params[:windows],
        macos: params[:macos],
        linuxos: params[:linux],
        message: params[:message],
        url: params[:url],
        like: 0,
        category_id: params[:category]
    })
    
    redirect '/'
end


