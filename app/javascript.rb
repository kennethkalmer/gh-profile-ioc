require 'v8'

# This service wraps V8 and allows us to interact with our Javascript
# directly in Ruby.
class Javascript

  # Our V8 context object
  attr_reader :context

  # Some delegations
  [ :load, :eval, :[], :[]= ].each do |delegate|
    define_method delegate do |*args|
      @context.send( delegate, *args )
    end
  end

  def initialize()
    @context = V8::Context.new

    # Setup a fake 'window' object
    @context['window'] = FakeWindow.new( @context )

    # Some namepaces and configuration for our JS
    @context.eval <<-EOJS
    var Profile = {};
    EOJS

    # Load backbone
    load File.expand_path("../../assets/javascripts/underscore.js", __FILE__)
    load File.expand_path("../../assets/javascripts/backbone.js", __FILE__)

    # Load all our coffeescripts
    %w( user layout ).each do |asset|
      load_coffee File.expand_path("../../assets/javascripts/#{asset}.js.coffee", __FILE__)
    end
  end

  # This class facilitates settings up a fake 'window' object in the missing dom
  # in our V8 context. Assign an instance of this class to the 'window' object
  # in the context, and any property defined on the instance will be set as a
  # global in the context...
  class FakeWindow
    # Initiate a fake window, passing a V8 context
    def initialize( context )
      @context = context
    end

    # Whatever property gets set here gets set on the provided context
    def []=( property, value )
      @context[ property ] = value
    end
  end

  def fake_dom!
    # Load underscore as dependency
    if context['_'].nil?
      context.load File.expand_path.("../../assets/javascripts/underscore.js", __FILE__)
    end

    # This sets up a fake $ callback handler for our own compiled coffeescript
    # files, and pushes the handlers onto a queue for later evaluation
    context.eval <<-EOJS
    readyQ = [];
    $ = function( handler ) {
      readyQ.push( handler );
    }
    EOJS

    yield

    # Now simply trigger each handler in the queue
    context.eval <<-EOJS
    _.each( readyQ, function(handler) { handler() } );
    readyQ = [];
    EOJS

    @dom_faked = true
  end

  # Compile and load a CoffeeScript file into the current context
  def load_coffee( path )
    compiled_coffeescript = CoffeeScript.compile( File.read( path ) )
    context.eval compiled_coffeescript
  end
end
