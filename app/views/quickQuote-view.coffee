template = require 'views/templates/quickQuote'
View = require 'views/base/view'
mediator = require 'mediator'


module.exports = class QuickQuoteView extends View
  autoRender: yes
  container: '#topRow'
  template: template

  initialize: ()=>
    super
    mediator.subscribe "quickQuoteView", @postcodeSearch

  render:()=>
    @$el.hide()
    super
    @$el.fadeIn()

  postcodeSearch:(item)=>
    console.log item    
    @closeLoginErrorAlert()    
    $.ajax
      url: "/api/postcode",
      type: "post",
      data: {postcode : item},
      statusCode:
        422: ()->
          outOfBounds(item)
        200: ()->
          inBounds(item)
        502: ()->
          showErrorAlert("<strong>Whoops - Something has gone wrong</strong> Please try again.")
      success: (jqXhr, textStatus)->
        console.log jqXhr
      error: ()->
        console.log "error"



  outOfBounds = (postcode)=>
    console.log "out of bounds " + postcode

  inBounds = (postcode)=>
    console.log "in bounds " +  postcode

  closeLoginErrorAlert:()=>
    @$('#validPostcode').hide()

  showErrorAlert = (message)=>
    $('#postcodeResult').html(message)
    $('#validPostcode').show()
      