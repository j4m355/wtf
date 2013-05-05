template = require 'views/templates/home/services'
View = require 'views/base/view'
mediator = require 'mediator'


module.exports = class InboundView extends View
  autoRender: yes
  container: '#topRow'
  template: template

  initialize: ()=>
    super    
    mediator.subscribe "servicesViewLoad", @whatToRender

  render:()=>
    super

  whatToRender:(inBounds)=>
  	console.log inBounds


      