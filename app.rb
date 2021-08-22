require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require './models/contribution.rb'

before do

    Dotenv.load
    Cloudinary.config do |config|
        config.cloud_name = ENV['CLOUD_NAME']
        config.api_key = ENV['CLOUDINARY_API_KEY']
        config.api_secret = ENV['CLOUDINARY_API_SECRET']
    end

end

get '/' do
    @contributions = Contribution.all
    @categories = Category.all
    erb :index
end

post '/create' do
    user_icon_url = ''
    if params[:user_icon]
        img = params[:user_icon]
        tempfile = img[:tempfile]
        upload = Cloudinary::Uploader.upload(tempfile.path)
        user_icon_url = upload['url']
    end
    
    # app_icon_url = ''
    # if params[:app_icon]
    #     img = params[:app_icon]
    #     tempfile = img[:tempfile]
    #     upload = Cloudinary::Uploader.upload(tempfile.path)
    #     app_icon_url = upload['url']
    # end
    
    # img_url = ''
    # if params[:image]
    #     img = params[:image]
    #     tempfile = img[:tempfile]
    #     upload = Cloudinary::Uploader.upload(tempfile.path)
    #     img_url = upload['url']
    # end
    
    Contribution.create({
        main_title: params[:main_title],
        sub_title: params[:sub_title],
        user_name: params[:user_name],
        winos: params[:windows],
        macos: params[:mac],
        linuxos: params[:linux],
        message: params[:message],
        url: params[:url],
        like: 0,
        pass: params[:pass],
        category_id: params[:category],
        user_icon: user_icon_url,
        # app_icon: app_icon_url,
        # img: img_url
    })
    
    redirect '/'
end

get '/category/:id' do
   @categories = Category.all
   @category = Category.find(params[:id])
   @category_name = @category.name
   @contributions = @category.contributions
   
   erb :index
end

post '/good/:id' do
    content = Contribution.find(params[:id])
    like = content.like
    content.update({
        like: like + 1
    })
    
    redirect '/'

end

post '/delete/:id' do
    Contribution.find(params[:id]).destroy
    redirect '/'
end

get '/edit/:id' do
    @content = Contribution.find (params[:id])
    @categories = Category.all
    erb :edit
end

post '/renew/:id' do

    content = Contribution.find(params[:id])
    content.update({
        main_title: params[:main_title],
        sub_title: params[:sub_title],
        user_name: params[:user_name],
        message: params[:message],
        url: params[:url],
        like: 0,
        category_id: params[:category],
        pass: params[:pass]
    })
    
    redirect '/'
end

