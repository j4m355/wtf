Controller = require 'controllers/base/controller'
HomePageView = require 'views/view-controllers/home/home-page-view'
AppointmentsView = require 'views/view-controllers/appointment/appointments-view'
PricesView = require 'views/view-controllers/prices/prices-view'
ContactView = require 'views/view-controllers/contact/contact-view'
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
