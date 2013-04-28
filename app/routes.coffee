module.exports = (match) ->
  match '', 'home#index'
  match 'Appointments', 'home#appointments'
  match 'Prices', 'home#prices'
  match 'Contact', 'home#contact'
  match 'Quick-Quote', 'home#quote'
