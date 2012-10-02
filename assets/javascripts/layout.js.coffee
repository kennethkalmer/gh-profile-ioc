# Profile layout
class Profile.Layout

  constructor: (options) ->
    @user = options.user
    @view = options.view

  render: ->
    @view.render( @user.attributes )
