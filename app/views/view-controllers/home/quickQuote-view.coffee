template = require 'views/templates/home/quickQuote'
View = require 'views/base/view'
mediator = require 'mediator'
Spinner = components 'spin.js'
InboundView = require 'views/view-controllers/home/inbound-view'
OutboundView = require 'views/view-controllers/home/outbound-view'

denzel = new Spinner({color:'#e5e5e5', lines: 13, className: 'spinner', length: 20, width:10,radius:30,corners:1.0,rotate:0,trail:60,speed:1.0,direction:1,shadow:off}).spin()

module.exports = class QuickQuoteView extends View
  autoRender: yes
  container: '#topRow'
  template: template

  initialize: ()=>
    super
    mediator.subscribe "quickQuoteView", @postcodeSearch


  render:()=>
    #@$el.hide() 
    super

  postcodeSearch:(item)=>
    @$('#spinner').append(denzel.el)
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
      error: (jqXhr, textStatus, errorThrown)->
        console.log errorThrown
      complete: ()->        
        denzel.stop() 





  outOfBounds = (postcode)=>
    new OutboundView(container: @$("#topRow"))
    console.log "out of bounds " + postcode
    @dispose

  inBounds = (postcode)=>
    new InboundView(container: @$("#topRow"))
    console.log "in bounds " +  postcode
    @dispose

  closeLoginErrorAlert:()=>
    @$('#validPostcode').hide()

  showErrorAlert = (message)=>
    $('#postcodeResult').html(message)
    $('#validPostcode').show()
      