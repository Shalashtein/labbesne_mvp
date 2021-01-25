module.exports = {
  test: /\.erb$/,
  enforce: 'pre',
  exclude: /node_modules/,
  use: [{
    loader: 'rails-erb-loader',
    options: {
      env:        {
        ...process.env,
        DISABLE_SPRING: 1,
      },
      runner: (/^win/.test(process.platform) ? 'ruby ' : '') + 'bin/rails runner'
    }
  }]
}
