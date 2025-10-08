const path = require('path');

module.exports = {
  dependency: {
    platforms: {
      android: {
        sourceDir: null, // disable Android platform
        packageImportPath: null,
      },
      ios: {
        podspecPath: path.join(__dirname, 'MapboxNavigation.podspec'),
      },
    },
  },
};
