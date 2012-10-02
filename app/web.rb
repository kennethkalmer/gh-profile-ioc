require 'sinatra'

module Profile
  class Web < Sinatra::Base
    # Our root path
    set :root, File.expand_path('../../', __FILE__)

    get '/' do
      @user = File.read( File.expand_path('../../data/user.json', __FILE__) )
      haml :index
    end

  end
end
