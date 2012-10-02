# Profile view
class Profile.View extends Backbone.View
  template: HandlebarsTemplates['profile']

  render: (context) ->
    @$el.empty().append @template( context )
