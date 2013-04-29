View = require 'views/base/view'
template = require 'views/templates/page/footer'

module.exports = class FooterView extends View
  autoRender: yes
  className: 'footer'
  region: 'footer'
  id: 'footer'
  template: template
