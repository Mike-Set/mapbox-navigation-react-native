#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

function addMapboxDependenciesToPodfile() {
  // Find the iOS directory - could be in different locations
  const possiblePaths = [
    path.join(process.cwd(), 'ios', 'Podfile'),
    path.join(process.cwd(), '..', 'ios', 'Podfile'),
    path.join(process.cwd(), '..', '..', 'ios', 'Podfile'),
  ];

  let podfilePath = null;
  for (const possiblePath of possiblePaths) {
    if (fs.existsSync(possiblePath)) {
      podfilePath = possiblePath;
      break;
    }
  }

  if (!podfilePath) {
    console.log(`
⚠️  Could not find Podfile automatically.
   Please manually add these lines to your ios/Podfile:

   pod 'MapboxNavigationCore', :git => 'https://github.com/mapbox/mapbox-navigation-ios.git', :tag => 'v3.12.1'
   pod 'MapboxNavigationUIKit', :git => 'https://github.com/mapbox/mapbox-navigation-ios.git', :tag => 'v3.12.1'
`);
    return;
  }

  let podfileContent = fs.readFileSync(podfilePath, 'utf8');

  // Check if Mapbox dependencies are already added
  if (podfileContent.includes('MapboxNavigationCore') && podfileContent.includes('MapboxNavigationUIKit')) {
    console.log('✅ Mapbox Navigation dependencies already present in Podfile');
    return;
  }

  // Add Mapbox dependencies after the target declaration
  const mapboxDeps = `
  # Mapbox Navigation dependencies (added by mapbox-navigation-react-native)
  pod 'MapboxNavigationCore', :git => 'https://github.com/mapbox/mapbox-navigation-ios.git', :tag => 'v3.12.1'
  pod 'MapboxNavigationUIKit', :git => 'https://github.com/mapbox/mapbox-navigation-ios.git', :tag => 'v3.12.1'
`;

  // Find the first target and add dependencies after it
  const targetRegex = /target\s+['"][^'"]+['"]\s+do/;
  const match = podfileContent.match(targetRegex);

  if (match) {
    const insertIndex = match.index + match[0].length;
    podfileContent = podfileContent.slice(0, insertIndex) + mapboxDeps + podfileContent.slice(insertIndex);

    fs.writeFileSync(podfilePath, podfileContent);
    console.log('✅ Added Mapbox Navigation dependencies to Podfile');
    console.log('📱 Run "cd ios && pod install" to install the dependencies');
  } else {
    console.log(`
⚠️  Could not automatically modify Podfile.
   Please manually add these lines to your ios/Podfile inside your target:

   pod 'MapboxNavigationCore', :git => 'https://github.com/mapbox/mapbox-navigation-ios.git', :tag => 'v3.12.1'
   pod 'MapboxNavigationUIKit', :git => 'https://github.com/mapbox/mapbox-navigation-ios.git', :tag => 'v3.12.1'
`);
  }
}

console.log(`
✅ Mapbox Navigation React Native installed successfully!

🎯 This package integrates with Mapbox Navigation SDK v3.12.1+ from GitHub repository
   for better reliability and compatibility.
`);

addMapboxDependenciesToPodfile();

console.log(`

📋 Next steps:

1. 🗝️  Configure your Mapbox access token in app.config.ts:
   
   export default {
     expo: {
       plugins: [
         [
           "@rnmapbox/maps",
           {
             RNMapboxMapsImpl: "mapbox",
             RNMapboxMapsDownloadToken: "YOUR_ACCESS_TOKEN"
           }
         ]
       ]
     }
   };

2. 📱 Install iOS dependencies:
   cd ios && pod install

3. 🚀 Start using Mapbox Navigation:
   import MapboxNavigation from 'mapbox-navigation-react-native';

📖 For detailed setup instructions, see: README.md
🐛 Issues? Visit: https://github.com/sneleentaxi/mapbox-navigation-react-native/issues
`);
