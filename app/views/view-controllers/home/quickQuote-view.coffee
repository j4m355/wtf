template = require 'views/templates/home/quickQuote'
View = require 'views/base/view'
mediator = require 'mediator'
Spinner = components 'spin.js'


denzel = new Spinner({color:'#e5e5e5', lines: 13, className: 'spinner', length: 20, width:10,radius:30,corners:1.0,rotate:0,trail:60,speed:1.0,direction:1,shadow:off}).spin()

module.exports = class QuickQuoteView extends View
  autoRender: yes
  container: '#topRow'
  template: template

  initialize: ()=>
    super
    mediator.subscribe "quickQuoteViewLoad", @postcodeSearch


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
      ###complete: ()->        
        denzel.stop()###

  outOfBounds = (postcode)=>
    denzel.stop() 
    mediator.publish 'closeQuickQuoteView', postcode
    #@mediator.publish 'servicesViewLoad', postcode
    #outboundView = new OutboundView(autoRender: true, container: @$('#topRow'))
    #@subview 'outboundView', outboundView
    console.log "out of bounds " + postcode
    #@dispose

  inBounds = (postcode)=>
    denzel.stop()     
    mediator.publish 'closeQuickQuoteView', postcode
    #inboundView = new InboundView(autoRender: true, container: @$('#topRow'))
    #@subview 'inboundView', inboundView
    console.log "in bounds " +  postcode
    #@dispose

  closeLoginErrorAlert:()=>
    @$('#validPostcode').hide()

  showErrorAlert = (message)=>
    $('#postcodeResult').html(message)
    $('#validPostcode').show()
      