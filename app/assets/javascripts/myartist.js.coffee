window.Myartist =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: -> 
  	new Myartist.Routers.Entries()
  	Backbone.history.start()
  

$(document).ready ->
  Myartist.init()
