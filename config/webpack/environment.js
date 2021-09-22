const { environment } = require('@rails/webpacker');
var webpack = require('webpack');

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

environment.plugins.prepend('Provide-FlatPicker',
  new webpack.ProvidePlugin({
    $: 'flatpickr/dis',
    flatpickr: 'flatpickr/dis/flatpickr.js'
  })
)
module.exports = environment