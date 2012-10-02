# String everything together into an application

$ ->

  # Load our user data from the cached JSON in the DOM
  user = new Profile.User( Profile.user )

  # Setup a view that will do the rendering
  view = new Profile.View
    el: '#user-profile'

  # Setup a new layout that will render the data
  layout = new Profile.Layout
    view: view
    user: user

  # Render it out
  layout.render()
