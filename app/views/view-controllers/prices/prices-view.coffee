template = require 'views/templates/prices/prices'
View = require 'views/base/view'

module.exports = class PricesView extends View
  autoRender: yes
  className: 'prices-page'
  container: '#page-container'
  template: template

  render: ()=>
  	@$el.hide()
  	super
  	@$el.fadeIn()
  	#@$el.show('slide', {direction : 'right'}, 1000)
