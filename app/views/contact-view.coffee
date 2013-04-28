template = require 'views/templates/contact'
View = require 'views/base/view'
mediator = require 'mediator'

module.exports = class ContactView extends View
  autoRender: yes
  className: 'contact-page'
  container: '#page-container'
  template: template

  initialize: ()=>
    super
    @delegate 'click', '#submitContact', @postMessage
    @delegate 'click', '#closeSuccess', @closeSuccess
    @delegate 'click', '#closeError', @closeError
    #@subscribeEvent 'postcodeSearch', @backPassage

  render:()=>
    @$el.hide()
    super
    @$('#contactSuccess').hide()
    @$('#contactError').hide()
    @$el.fadeIn()
    #@$el.show('slide', {direction : 'right'}, 1000)

  backPassage:()=>
    console.log "egg"


  postMessage:()=>
    valid = validate()
    console.log "valid?  " + valid
    if valid
      $('#contactError').hide()
      showSuccessAlert("<p> <strong>Thank you for your message we will be in touch soon. </strong>Please check your junk mail just in case.</P>")
      $.ajax
        url: "/api/contact/create",
        type: "post",
        data: $('#ContactForm').serialize()
        error: ()->
          $('#contactSuccess').hide()
          showErrorAlert("<p> <strong>Oops somethign has gone wrong. </strong>Please contact us on 07519746777 and we can sort you out.</P>")


  closeSuccess:()=>
    @$('#contactSuccess').hide()

  closeError:()=>
    @$('#contactError').hide()

  showSuccessAlert = (message)=>
    $('#successMessage').html(message)
    $('#contactSuccess').show()

  showErrorAlert = (message)=>
    $('#errorMessage').html(message)
    $('#contactError').show()

  validate = ()=>
    errors = []
    contactName = $('#contactName').val()
    contactEmail = $('#contactEmail').val()
    contactMessage = $('#contactMessage').val()
    contactSource = $('#contactSource').val()
    isEmail = validateEmail(contactEmail)
    isPhone = validatePhone(contactEmail)
    console.log "IsEmail: " + isEmail
    console.log "isPhone: " + isPhone
    errors.push "<strong>Please fill out the following information: </strong><br>"
    if contactName.length < 1
      errors.push "-Your Name <br>"
    if contactMessage.length < 1
      errors.push "-Your Query <br>"
    if contactSource == "--Please Select--"
      errors.push "-How you heard of us <br>"
    if contactEmail.length < 1
      errors.push "-Your Email / Phone <br>"
    else
      valid = false
      if !isEmail && !isPhone
        errors.push "-Invalid Phone Number or Email Address <br>"
        valid = true
      else if isEmail
        valid = true        
      else if isPhone
        valid = true
      if !valid
        errors.push "-Invalid Phone Number or Email Address <br>"
    if errors.length >1
      showErrorAlert(errors)
      return false
    else
      return true

  validateEmail = (email)=>
    re = /\S+@\S+\.\S+/
    return re.test(email)

  validatePhone = (number)=>
    re = /\d{11}/
    return re.test(number)



