require 'javascript'
require 'prawn'

module Profile

  class Pdf

    def initialize( user )
      @user = user

      # Load our javascript
      @javascript = Javascript.new

      # Setup ourselves as the view to render the data
      @javascript['view'] = self

      # Setup the rest of the JS context
      @javascript.eval <<-EOJS
        // Load our user data from the cached JSON in the DOM
        var user = new Profile.User( #{@user.to_json} );

        // Setup a new layout that will render the data
        var layout = new Profile.Layout({
          view: view,
          user: user
        });

        // Render it out
        //layout.render();
      EOJS

      @pdf = Prawn::Document.new
    end

    # Our render context
    def render( context )

      @pdf.font_size 40
      @pdf.text context.login

      @pdf.move_down 20
      @pdf.font_size 20
      @pdf.text context.name
    end

    def stream

      @javascript['layout']['render'].methodcall( @javascript['layout'] )
      @pdf.render
    end

  end
end
