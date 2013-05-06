template = require 'views/templates/home/home'
View = require 'views/base/view'
mediator = require 'mediator'

PostcodeModel = require 'models/postcode'

CarouselView = require './carousel-view'
QuickQuoteView = require 'views/view-controllers/home/quickQuote-view'


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
    #@$el.fadeIn()

  closeCarouselView:(postcode)=>
    @removeSubview(@carouselView)
    postcodeInRange = postcodeSearch(postcode)
    item = new PostcodeModel({postcode : postcode, inbounds: postcodeInRange})
    quickQuoteView = new QuickQuoteView(autoRender: true, container: @$("#topRow"), model : item)  
    @subview 'quickQuoteView', quickQuoteView
    #mediator.publish "quickQuoteViewLoad", postcode    

  closeQuickQuoteView:(success)=>
    @removeSubview(@quickQuoteView)
    servicesView = new ServicesView(autoRender : true, container: @$("#topRow"))
    @subView 'servicesView', servicesView
    mediator.publish "servicesViewLoad", success

  postcodeSearch = (item)=>
    if validatePostcode(item)
      return true
    else
      return false

  validatePostcode = (postcode)=>
    @model = new PostcodeModel({postcode : postcode}) 
    removeWhite = postcode.replace(" ", "")
    trimStart = removeWhite.substr(2)
    positionOfLastTwo = trimStart.length - 2
    answer = trimStart.substr(0,positionOfLastTwo)
    if answer < 110
      @model.set({inbounds : true})
      console.log @model.attributes 
      return true
    else
      @model.set({inbounds : false})
      console.log @model.attributes
      return false
