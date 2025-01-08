module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*',
  ],
  theme: {
    extend: {
      backgroundImage: {
        'sberpay-gradient': 'linear-gradient(150deg, rgb(242, 234, 0) 0%, rgb(3, 211, 29) 35%, rgb(15, 182, 254) 100%)',
      },
    },
  },
  plugins: [],
}
