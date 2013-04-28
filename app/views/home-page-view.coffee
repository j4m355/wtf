template = require 'views/templates/home'
View = require 'views/base/view'
mediator = require 'mediator'
Spinner = components 'spin.js'
CarouselView = require './carousel-view'


module.exports = class HomePageView extends View
  autoRender: yes
  className: 'home-page'
  container: '#page-container'
  template: template

  initialize:()=>
    super

  render:()=>
    @$el.hide()
    super
    new CarouselView(
      container: @$("#topRow"))
    @$el.fadeIn()

    #@$el.show('slide', {direction : 'right'}, 1000)