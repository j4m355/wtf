Chaplin = require 'chaplin'
SiteView = require 'views/site-view'
HeaderView = require 'views/view-controllers/page/header-view'
FooterView = require 'views/view-controllers/page/footer-view'

module.exports = class Controller extends Chaplin.Controller
  beforeAction:
    '.*': ->
      @compose 'site', SiteView
      @compose 'header', HeaderView
      @compose 'footer', FooterView
