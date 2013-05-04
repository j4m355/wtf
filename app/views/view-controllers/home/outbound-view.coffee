template = require 'views/templates/home/outbound'
View = require 'views/base/view'
mediator = require 'mediator'


module.exports = class OutboundView extends View
  autoRender: yes
  container: '#topRow'
  template: template

  initialize: ()=>
    super

  render:()=>
    super
      