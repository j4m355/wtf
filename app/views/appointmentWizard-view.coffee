template = require 'views/templates/appointmentWizard'
View = require 'views/base/view'
mediator = require 'mediator'

Calendar = components('calendar')

module.exports = class AppointmentWizardView extends View
  autoRender: yes
  className: 'contact-page'
  container: '#page-container'
  template: template

  initialise:()=>
    super
    mediator.subscribe 'postcodeSearch', @backPassage

  backPassage:(postcode)=>
    console.log postcode
    $.ajax
      url: "/api/postcode/?postcode=" + postcode,
      type: "post"
      error: (e)->
        console.log e
      success: (e)->
        console.log e

    console.log "linesman"

  render:()=>
  	super
  	calendar = new Calendar()
  	calendar.el.appendTo(@$('#calendarView'))
  	calendar.on 'change', @select
  
  select: (dateOrEvent) =>
    if $(dateOrEvent.currentTarget).text() != "Next"
      if dateOrEvent.getTime
        @set dateOrEvent
      else
        @set new Date(dateString)