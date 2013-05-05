template = require 'views/templates/appointment/appointments'
View = require 'views/base/view'

Calendar = components('calendar')

module.exports = class AppointmentsView extends View
  autoRender: yes
  className: 'appointments-page'
  container: '#page-container'
  template: template

  render:()=>
    @$el.hide()
    super
    calendar = new Calendar()
    calendar.el.appendTo(@$('#calendarView'))
    calendar.on 'change', @select
    @$el.fadeIn()
  
  select: (dateOrEvent) =>
    if $(dateOrEvent.currentTarget).text() != "Next"
      if dateOrEvent.getTime
        @set dateOrEvent
      else
        @set new Date(dateString)