require 'sinatra'
require 'user'
require 'pdf'

module Profile
  class Web < Sinatra::Base
    # Our root path
    set :root, File.expand_path('../../', __FILE__)

    get '/' do
      @user = User.new
      haml :index
    end

    get '/pdf' do
      attachment "gtihub.pdf"
      Profile::Pdf.new( User.new ).stream
    end

  end
end
