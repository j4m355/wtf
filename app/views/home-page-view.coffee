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
    @$('.carousel').carousel()
    @$el.fadeIn()
    #@$el.show('slide', {direction : 'right'}, 1000)

  postcodeSearch:(e)=>
    if e.keyCode is 13
      valid = validate($('#postcodeBox').val())
      console.log valid
      if valid
        $.ajax
          url: "/api/postcode",
          type: "post",
          data: $('#postcodeBox').serialize()
          success: (jqXhr, textStatus)->
            console.log jqXhr
          error: ()->
            console.log "error"


  validate = ()=>
    errors = []
    postcode = $('#postcodeBox').val()
    if postcode.length < 1 || !validatePostcode()
      errors.push "Please use a valid postcode"
    if errors.length >0
      showErrorAlert(errors)
      return false
    else
      return true

  closeLoginSuccsesAlert:()=>
    @$('#loginSuccsesAlert').hide()

  closeLoginErrorAlert:()=>
    @$('#loginErrorAlert').hide()

  showSuccessAlert = (message)=>
    $('#successMessage').html(message)
    $('#loginSuccsesAlert').show()

  showErrorAlert = (message)=>
    $('#errorMessage').html(message)
    $('#loginErrorAlert').show()

  validatePostcode = (postcode)=>
    re = /^(?!bt)/
    re2 = /^([A-PR-UWYZ0-9][A-HK-Y0-9][AEHMNPRTVXY0-9]?[ABEHMNPRVWXY0-9]? {0,2}[0-9][ABD-HJLN-UW-Z]{2}|GIR ?0AA)$/
    bttest = re.test(postcode)
    postcodetest = re2.test(postcode)
    console.log "bttest" + bttest
    console.log "postcodetest" + postcodetest
    if bttest
      return postcodetest
    else
      return false

  validatePhone = (number)=>
    re = /\d{11}/
    return re.test(number)

      