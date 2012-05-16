class Myartist.Views.Entry extends Backbone.View

  template: JST['entries/entry']
  tagName: 'section'
  className: 'artists'
  

  render: ->
    $(@el).html(@template(entry: @model))
    elem =  $(this.el)
    @getinfo elem
    @gettwitter elem

    this


# GET THE IMAGE

  getinfo: (el) ->
    parent = $(el)
    unique = parent.find('.unique').text()
    imagebox = parent.find('.imgbox')
    if unique
      console.log
      $.ajax
        url: "http://developer.echonest.com/api/v4/artist/images"
        dataType: "jsonp"
        data:
          results: 15
          
          api_key: "K9Q5GBFOFF77YTYIY"
          format: "jsonp"
          name: unique
        success: (data) ->

          if data.response.images[1]
            cheese = data.response.images[1].url

            imagebox.css( "background-image", "url("+cheese+")" )
            imagebox.data('url', 'pie')
        
# GET THE TWITTER 
  gettwitter: (el) ->
    parent = $(el)
    unique = parent.find('h1').text()
    console.log unique
    meme = 'http://27.media.tumblr.com/tumblr_lu4bsl2f731qfu4tho1_500.png'
    $.ajax(
      url: "http://developer.echonest.com/api/v4/artist/twitter"
      dataType: "jsonp"
      data:
        api_key: "K9Q5GBFOFF77YTYIY"
        format: "jsonp"
        name: unique
      success: (data) ->
        handle = data.response.artist.twitter
        if handle
          parent.append('<a class="twitter" href="http://twitter.com/' + handle + '"  >@' + handle + '</a>')
        else
          parent.append('<a class="toobad" href="' + meme + '"' + "  >doesn't tweet</a>")
      )

