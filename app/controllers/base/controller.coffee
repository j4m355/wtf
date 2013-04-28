Chaplin = require 'chaplin'
SiteView = require 'views/site-view'
HeaderView = require 'views/header-view'
FooterView = require 'views/footer-view'

module.exports = class Controller extends Chaplin.Controller
  beforeAction:
    '.*': ->
      @compose 'site', SiteView
      @compose 'header', HeaderView
      @compose 'footer', FooterView
