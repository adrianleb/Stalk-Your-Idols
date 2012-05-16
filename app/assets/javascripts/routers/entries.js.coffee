class Myartist.Routers.Entries extends Backbone.Router
  routes:
  	'': 'index'
  	'entries/:id': 'show'
  	'delete/:id': 'gone'


  initialize: ->
  	@collection = new Myartist.Collections.Entries()
  	@collection.fetch()

  index: ->
    view = new Myartist.Views.EntriesIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "entry #{id}"

  gone: (id) ->
  	entry = @collection.get(id)
  	entry.destroy()

