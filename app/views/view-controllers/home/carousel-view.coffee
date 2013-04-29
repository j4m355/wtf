template = require 'views/templates/home/carousel'
View = require 'views/base/view'
mediator = require 'mediator'
QuickQuoteView = require './quickQuote-view'


module.exports = class CarouselView extends View
  autoRender: yes
  container: '#topRow'
  template: template

  initialize: ()=>
    super
    @delegate 'keyup', '#postcodeBox', @postcodeSearch

  render:()=>
    super
    @closeLoginErrorAlert()
    @$('.carousel').carousel()
    #@$el.show('slide', {direction : 'right'}, 1000)

  postcodeSearch:(e)=>
    if e.keyCode is 13
      postcode = $('#postcodeBox').val()
      if validate(postcode)
        @$el.fadeOut()
        new QuickQuoteView()
        mediator.publish "quickQuoteView", postcode
        @dispose


  validate = (postcode)=>
    errors = []
    if postcode.length < 1 || !validatePostcode(postcode)
      errors.push "Please use a valid postcode"
    if errors.length >0
      showErrorAlert(errors)
      return false
    else
      return true

  closeLoginErrorAlert:()=>
    @$('#validPostcode').hide()

  showErrorAlert = (message)=>
    $('#postcodeResult').html(message)
    $('#validPostcode').show()

  validatePostcode = (postcode)=>
    console.log postcode
    postcodeRegEx = /^([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9]?[A-Za-z])))) {0,1}[0-9][A-Za-z]{2})$/
    belfastPostcode = /^([Bb][Tt])/
    if belfastPostcode.test(postcode)
      return postcodeRegEx.test(postcode)
    else
      return false
      