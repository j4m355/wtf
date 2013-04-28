template = require 'views/templates/home'
View = require 'views/base/view'
mediator = require 'mediator'
AppointmentWizardView = require './appointmentWizard-view'
Spinner = components 'spin.js'


module.exports = class HomePageView extends View
  autoRender: yes
  className: 'home-page'
  container: '#page-container'
  template: template

  initialize: ()=>
    super
    @delegate 'keyup', '#postcodeBox', @postcodeSearch

  render:()=>
    @$el.hide()
    super
    @closeLoginErrorAlert()
    @$('.carousel').carousel()
    @$el.fadeIn()
    #@$el.show('slide', {direction : 'right'}, 1000)

  postcodeSearch:(e)=>
    if e.keyCode is 13
      @closeLoginErrorAlert()
      postcode = $('#postcodeBox').val()
      valid = validate(postcode)
      if valid
        $.ajax
          url: "/api/postcode",
          type: "post",
          data: $('#postcodeBox').serialize()
          statusCode:
            422: ()->
              showErrorAlert("Postcode not in service area.")
            502: ()->
              showErrorAlert("<strong>Whoops - Something has gone wrong</strong> Please try again.")
          success: (jqXhr, textStatus)->
            console.log jqXhr
          error: ()->
            console.log "error"


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
      