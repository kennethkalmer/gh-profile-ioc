# Profile layout
class Profile.Layout

  constructor: (options) ->
    @user = options.user
    @view = options.view

  render: ->
    context =
      login: @user.get('login')
      name: @user.get('name')

    context.login = "@#{context.login}"

    @view.render( context )
