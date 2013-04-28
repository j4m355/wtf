template = require 'views/templates/quote'
View = require 'views/base/view'

module.exports = class QuoteView extends View
  autoRender: yes
  className: 'quote-page'
  container: '#page-container'
  template: template

  render:()=>
    @$el.hide()
    super    
    @$el.fadeIn()
    #@$el.show('slide', {direction : 'right'}, 1000)