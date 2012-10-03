require 'json'

module Profile

  # Low and behold, the actual user...
  class User

    def initialize
      @data = JSON.parse File.read( File.expand_path('../../data/user.json', __FILE__) )
    end

    def to_json
      @data.to_json
    end

  end

end
