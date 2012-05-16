class Myartist.Views.EntriesIndex extends Backbone.View

  template: JST['entries/index']
  tagName: 'div'
  className: "wrapper"
  events:
    'submit #new_entry': 'createEntry'
    'click .destroyLink': 'deleteEntry'
    



  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendEntry, this)


  render: ->
    field = undefined
    $(@el).html @template()
    @collection.each @appendEntry
    field = $("#new_entry_name")
    artists = $(".artists")



    	# AUTOCOMPLETE AWESOMENESS
    field.autocomplete
      source: (request, response) ->
        $.ajax
          url: "http://developer.echonest.com/api/v4/artist/suggest"
          dataType: "jsonp"
          data:
            results: 6
            api_key: "K9Q5GBFOFF77YTYIY"
            format: "jsonp"
            name: request.term

          success: (data) ->
            response $.map(data.response.artists, (item) ->
              label: item.name
              value: item.name
              id: item.id
            )
#APPEND TO SECRET BOX
      minLength: 3
      select: (event, ui) ->
        name = ui.item
        uniqueid = ui.id
        $("#new_entry_id").empty()
        $("#new_entry_id").append(ui.item.id);

    this


  appendEntry: (entry) ->
    view = new Myartist.Views.Entry(model: entry)
    counter = 0
    $('#entries').prepend(view.render().el)






  createEntry: (event) ->
  	event.preventDefault()
  	attributes = 
  		name: $('#new_entry_name').val()
  		uniqueid: $("#new_entry_id").text()
# APPEND TO COLLECTION
  	@collection.create attributes,
  	  wait: true
  	  success: -> $('#new_entry')[0].reset()
  	  error: @handleError
  
# IF SHIT HAPPENDS
  handleError: (entry, response) ->
  	if response.status == 422
  		errors = $.parseJSON(response.responseText).errors
  		for attribute, messages of errors
  			alert "#{attribute} #{message}" for message in messages



  deleteEntry: (event) =>
    event.preventDefault()
    el = event.srcElement
    parent = $(el).parent()
    console.log parent
    id = event.toElement.dataset.pie
    entry = @collection.get(id)
    entry.destroy()
    parent.remove()




