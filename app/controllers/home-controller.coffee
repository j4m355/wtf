Controller = require 'controllers/base/controller'
HomePageView = require 'views/home-page-view'
AppointmentsView = require 'views/appointments-view'
PricesView = require 'views/prices-view'
ContactView = require 'views/contact-view'
QuoteView = require 'views/quote-view'


module.exports = class HomeController extends Controller
  index: ->
    @view = new HomePageView region: 'main'
      
  appointments: =>
      @view = new AppointmentsView()

  prices: =>
      @view = new PricesView()

  contact: =>
      @view = new ContactView()

  quote: =>
      @view = new QuoteView()
