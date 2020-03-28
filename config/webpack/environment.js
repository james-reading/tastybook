const { environment } = require('@rails/webpacker')

Object.entries({
  jquery: ['$', 'jQuery']
}).forEach(([moduleName, exposedNames]) => {
  exposedNames = Array.isArray(exposedNames) ? exposedNames : [exposedNames];
  exposedNames.forEach(exposedName => {
    environment.loaders.append(`expose-${moduleName}-${exposedName}`, {
      test: require.resolve(moduleName),
      use: [
        {
          loader: 'expose-loader',
          options: exposedName
        }
      ]
    });
  });
});

// resolve-url-loader must be used before sass-loader
environment.loaders.get('sass').use.splice(-1, 0, {
  loader: 'resolve-url-loader'
});


module.exports = environment
