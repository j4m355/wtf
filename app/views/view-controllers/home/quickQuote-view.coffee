template = require 'views/templates/home/quickQuote'
View = require 'views/base/view'
mediator = require 'mediator'
Spinner = components 'spin.js'


#denzel = new Spinner({color:'#e5e5e5', lines: 13, className: 'spinner', length: 20, width:10,radius:30,corners:1.0,rotate:0,trail:60,speed:1.0,direction:1,shadow:off}).spin()

module.exports = class QuickQuoteView extends View
  autoRender: yes
  container: '#topRow'
  template: template

  initialize: ()=>
    super
    mediator.subscribe "quickQuoteViewLoad", @postcodeSearch

  render:()=>
    super
    @$("#wizard").wizardPro()

  postcodeSearch:(item)=> 
    @closeLoginErrorAlert()
    if validatePostcode(item)
      inBounds(item)
    else
      outOfBounds(item)

  validatePostcode = (postcode)=>
    console.log postcode
    removeWhite = postcode.replace(" ", "")
    trimStart = removeWhite.substr(2)
    positionOfLastTwo = trimStart.length - 2
    answer = trimStart.substr(0,positionOfLastTwo)
    if answer < 110
      return true
    else
      return false


  outOfBounds = (postcode)=>
    console.log "out of bounds " + postcode

  inBounds = (postcode)=>
    console.log "in bounds " +  postcode

  closeLoginErrorAlert:()=>
    @$('#validPostcode').hide()

  showErrorAlert = (message)=>
    $('#postcodeResult').html(message)
    $('#validPostcode').show()
      