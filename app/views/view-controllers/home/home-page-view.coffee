template = require 'views/templates/home/home'
View = require 'views/base/view'
mediator = require 'mediator'

CarouselView = require './carousel-view'
QuickQuoteView = require 'views/view-controllers/home/quickQuote-view'
ServicesView = require 'views/view-controllers/home/services-view'


module.exports = class HomePageView extends View
  autoRender: yes
  className: 'home-page'
  container: '#page-container'
  template: template

  initialize:()=>
    super
    mediator.subscribe "closeCarouselView", @closeCarouselView
    mediator.subscribe "closeQuickQuoteView", @closeQuickQuoteView

  render:()=>
    @$el.hide()
    super
    carouselView = new CarouselView(autoRender : true, container: @$("#topRow"))
    @subview 'carouselView', carouselView
    @$el.fadeIn()

  closeCarouselView:(postcode)=>
    @removeSubview(@carouselView)
    quickQuoteView = new QuickQuoteView(autoRender: true, container: @$("#topRow"))
    @subview 'quickQuoteView', quickQuoteView
    mediator.publish "quickQuoteViewLoad", postcode    

  closeQuickQuoteView:(success)=>
    @removeSubview(@quickQuoteView)
    servicesView = new ServicesView(autoRender : true, container: @$("#topRow"))
    @subView 'servicesView', servicesView
    mediator.publish "servicesViewLoad", success
