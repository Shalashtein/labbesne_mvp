const { environment } = require('@rails/webpacker')


const webpack = require('webpack');

// Preventing Babel from transpiling NodeModules packages
environment.loaders.delete('nodeModules');

// Bootstrap 4 has a dependency over jQuery & Popper.js:
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default'],
    Swing: 'swing',
    Direction: 'swing/dist/Direction.js',
    Stack: 'swing/dist/Stack.js',
    Card: 'swing/dist/Card.js',
    utilities: 'swing/dist/utilities.js'
  })
);

module.exports = environment
