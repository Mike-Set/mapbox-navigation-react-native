# Mapbox Navigation React Native# Mapbox Navigation React Native# Mapbox Navigation Native# Mapbox Navigation v3 Native Integration

A React Native wrapper for Mapbox Navigation v3 SDK (iOS only) using CocoaPods with direct GitHub repository integration.A React Native wrapper for Mapbox Navigation v3 SDK (iOS only) using CocoaPods.

## Installation## InstallationA React Native wrapper for Mapbox Navigation v3 SDK (iOS only).This module provides a React Native bridge to integrate Mapbox Navigation v3 SDK for iOS.

`bash`bash

npm install mapbox-navigation-react-native

# ornpm install mapbox-navigation-react-native

yarn add mapbox-navigation-react-native

````# or## Installation## Setup Instructions



For iOS, run:yarn add mapbox-navigation-react-native

```bash

cd ios && pod install```

````

For iOS, run:```bash### 1. Add Native Files to Xcode Project

## Setup

````bash

### iOS Requirements

cd ios && pod installnpm install mapbox-navigation-native

1. **Mapbox Account & Access Token**

   - Sign up at [Mapbox](https://account.mapbox.com/)```

   - Get your access token from the dashboard

   - Add your token to `app.config.ts`:# orYou need to manually add the native iOS files to your Xcode project:



```typescript## Setup

export default {

  expo: {yarn add mapbox-navigation-native

    plugins: [

      [### iOS Requirements

        "@rnmapbox/maps",

        {```1. Open `ios/SETDrivers.xcworkspace` in Xcode

          RNMapboxMapsImpl: "mapbox",

          RNMapboxMapsDownloadToken: "YOUR_ACCESS_TOKEN"1. **Mapbox Account & Access Token**

        }   - Sign up at [Mapbox](https://account.mapbox.com/)2. Right-click on the `SETDrivers` folder in the project navigator

      ]

    ]   - Get your access token from the dashboard

  }

};   - Add your token to `app.config.ts`:For iOS, run:3. Select "Add Files to SETDrivers"

````

`typescript`bash4. Navigate to `ios/SETDrivers/` and add these files:

2.  **Mapbox Navigation SDK via GitHub Repository**
    - The package automatically pulls Mapbox Navigation v3.12.1+ directly from the official GitHub repositoryexport default {

    - Uses `MapboxNavigationCore` and `MapboxNavigationUIKit` from `https://github.com/mapbox/mapbox-navigation-ios.git`

    - No additional manual setup required - everything is handled by the podspecexpo: {cd ios && pod install - `MapboxNavigationModule.h`

    - Ensures you get the latest compatible version

    plugins: [

3.  **CocoaPods Configuration**
    - Ensure your `ios/Podfile` has the minimum iOS version set to 12.0: [```  -`MapboxNavigationModule.m`

    ```ruby

    platform :ios, '12.0'        "@rnmapbox/maps",

    ```

         {5. Make sure "Add to target: SETDrivers" is checked

## Usage

          RNMapboxMapsImpl: "mapbox",

```typescript

import React, { useEffect, useState } from 'react';          RNMapboxMapsDownloadToken: "YOUR_ACCESS_TOKEN"## Setup6. Click "Add"

import { View, Text, Button } from 'react-native';

import MapboxNavigation from 'mapbox-navigation-react-native';        }



export default function NavigationScreen() {      ]

  const [isNavigating, setIsNavigating] = useState(false);

    ]

  useEffect(() => {

    // Initialize Mapbox Navigation}### iOS Requirements### 2. Add Mapbox Navigation v3 SDK

    MapboxNavigation.initialize('YOUR_MAPBOX_ACCESS_TOKEN')

      .then(() => console.log('Mapbox Navigation initialized'))};

      .catch((error) => console.error('Initialization error:', error));

```

    const navigationListener = MapboxNavigation.addListener('onNavigationStarted', () => {

      setIsNavigating(true);

    });

2. **Mapbox Navigation SDK via CocoaPods**1. **Mapbox Account & Access Token**Follow the instructions in `MAPBOX_NAVIGATION_SETUP.md`:

   const progressListener = MapboxNavigation.addListener('onRouteProgressChanged', (data) => {

   console.log('Route progress:', data); - The Mapbox Navigation SDK will be automatically installed via CocoaPods when you run `pod install`

   });
   - No additional manual setup required - the podspec handles all dependencies - Sign up at [Mapbox](https://account.mapbox.com/)

   const arrivalListener = MapboxNavigation.addListener('onFinalDestinationArrival', () => {

   setIsNavigating(false); - Make sure you have a valid Mapbox access token configured

   });
   - Get your access token from the dashboard1. Configure `.netrc` file with your Mapbox access token

   return () => {

   navigationListener?.remove();3. **CocoaPods Configuration**

   progressListener?.remove();

   arrivalListener?.remove(); - Ensure your `ios/Podfile` has the minimum iOS version set to 12.0: - Add your token to `app.config.ts`:2. In Xcode, go to **File > Add Package Dependencies...**

   };

}, []); ```ruby

const startNavigation = async () => { platform :ios, '12.0'3. Enter: `https://github.com/mapbox/mapbox-navigation-ios.git`

    try {

      await MapboxNavigation.startNavigation({````

        latitude: 37.7749,

        longitude: -122.4194,```typescript4. Set version to `3.12.1`

        name: "San Francisco"

      });## Usage

    } catch (error) {

      console.error('Navigation error:', error);export default {5. Add `MapboxNavigationCore` and `MapboxNavigationUIKit` to your target

    }

};````typescript

const stopNavigation = async () => {import React, { useEffect, useState } from 'react'; expo: {

    try {

      await MapboxNavigation.stopNavigation();import { View, Text, Button } from 'react-native';

      setIsNavigating(false);

    } catch (error) {import MapboxNavigation from 'mapbox-navigation-react-native';    plugins: [### 3. Uncomment Native Code

      console.error('Stop navigation error:', error);

    }

};

export default function NavigationScreen() { [

return (

    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>  const [isNavigating, setIsNavigating] = useState(false);

      <Text>Navigation Status: {isNavigating ? 'Active' : 'Inactive'}</Text>

              "@rnmapbox/maps",After adding the SPM package, uncomment these lines in `MapboxNavigationModule.m`:

      {!isNavigating ? (

        <Button title="Start Navigation" onPress={startNavigation} />  useEffect(() => {

      ) : (

        <Button title="Stop Navigation" onPress={stopNavigation} />    // Initialize Mapbox Navigation        {

      )}

    </View>    MapboxNavigation.initialize('YOUR_MAPBOX_ACCESS_TOKEN')

);

} .then(() => console.log('Mapbox Navigation initialized')) RNMapboxMapsImpl: "mapbox",```objc

````

      .catch((error) => console.error('Initialization error:', error));

## API Reference

          RNMapboxMapsDownloadToken: "YOUR_ACCESS_TOKEN"// @import MapboxNavigationCore;

### Methods

    const navigationListener = MapboxNavigation.addListener('onNavigationStarted', () => {

#### `initialize(accessToken: string): Promise<void>`

Initializes the Mapbox Navigation SDK with your access token.      setIsNavigating(true);        }// @import MapboxNavigationUIKit;



**Parameters:**    });

- `accessToken`: Your Mapbox access token

      ]```

#### `startNavigation(destination: Destination): Promise<void>`

Starts turn-by-turn navigation to the specified destination.    const progressListener = MapboxNavigation.addListener('onRouteProgressChanged', (data) => {



**Parameters:**      console.log('Route progress:', data);    ]

- `destination`: Object with `latitude`, `longitude`, and optional `name`

    });

#### `stopNavigation(): Promise<void>`

Stops the current navigation session.  }And implement the actual SDK integration code.



#### `addListener(eventName: string, callback: Function): Subscription`    const arrivalListener = MapboxNavigation.addListener('onFinalDestinationArrival', () => {

Adds an event listener for navigation events.

      setIsNavigating(false);};

### Events

    });

- `onNavigationStarted`: Fired when navigation begins

- `onRouteProgressChanged`: Fired during navigation with progress data```### 4. Update Configuration

- `onFinalDestinationArrival`: Fired when reaching the destination

- `onNavigationCancelled`: Fired when navigation is cancelled    return () => {



### Types      navigationListener?.remove();



```typescript      progressListener?.remove();

interface Destination {

  latitude: number;      arrivalListener?.remove();2. **Add Mapbox Navigation SDK**Update the access token in `app/(protected)/mapbox-navigation.tsx`:

  longitude: number;

  name?: string;    };

}

```  }, []);   - Open your iOS project in Xcode



## Platform Support



- ✅ iOS (iOS 12.0+)  const startNavigation = async () => {   - Go to your app target → Build Phases → Link Binary With Libraries```typescript

- ❌ Android (not supported)

    try {

## Dependencies

      await MapboxNavigation.startNavigation({   - Add the following via Swift Package Manager:await MapboxNavigation.initialize('your-actual-mapbox-access-token');

This package automatically installs the following dependencies directly from the Mapbox Navigation iOS repository:

        latitude: 37.7749,

- `MapboxNavigationCore` (v3.12.1+) from `https://github.com/mapbox/mapbox-navigation-ios.git`

- `MapboxNavigationUIKit` (v3.12.1+) from `https://github.com/mapbox/mapbox-navigation-ios.git`        longitude: -122.4194,     - `https://github.com/mapbox/mapbox-navigation-ios` (v3.x)```



### Why GitHub Repository Integration?        name: "San Francisco"



- ✅ **Always up-to-date**: Gets the latest compatible version directly from Mapbox      });

- ✅ **Reliable dependency resolution**: Avoids CocoaPods spec repository issues

- ✅ **Version locking**: Uses specific tag (v3.12.1) for stability    } catch (error) {

- ✅ **Better compatibility**: Ensures React Native works well with the exact Mapbox version

      console.error('Navigation error:', error);## Usage### 5. Build and Test

## Requirements

    }

- React Native >= 0.60.0

- iOS >= 12.0  };

- Xcode >= 12.0

- CocoaPods >= 1.10.0



## Troubleshooting  const stopNavigation = async () => {```typescript1. Clean and rebuild the project:



### Common Issues    try {



1. **Pod install fails**:       await MapboxNavigation.stopNavigation();import React, { useEffect, useState } from 'react';

   - Make sure you have the latest CocoaPods version

   - Clear CocoaPods cache: `pod cache clean --all`      setIsNavigating(false);

   - Delete `Podfile.lock` and `Pods/` directory, then run `pod install`

    } catch (error) {import { View, Text, Button } from 'react-native';   ```bash

2. **Mapbox SDK errors**:

   - Verify your access token is valid and has the correct permissions      console.error('Stop navigation error:', error);

   - Check that your access token supports Navigation SDK

    }import MapboxNavigation from 'mapbox-navigation-native';   cd ios && rm -rf build && cd ..

3. **Build errors**:

   - Clean your project and try rebuilding  };

   - Make sure iOS deployment target is 12.0+

   - Verify Xcode version compatibility   npx expo run:ios --device



### Debug Steps  return (



1. Check your Mapbox access token validity    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>export default function NavigationScreen() {   ```

2. Ensure iOS deployment target is 12.0+

3. Run `pod install --repo-update` to update pod repositories      <Text>Navigation Status: {isNavigating ? 'Active' : 'Inactive'}</Text>

4. Clean and rebuild your project

5. Check that GitHub repository is accessible (network connectivity)        const [isNavigating, setIsNavigating] = useState(false);



## Advanced Configuration      {!isNavigating ? (



### Custom Mapbox Version        <Button title="Start Navigation" onPress={startNavigation} />2. Navigate to the navigation screen to test the integration



If you need a specific version of Mapbox Navigation, you can fork this package and modify the podspec:      ) : (



```ruby        <Button title="Stop Navigation" onPress={stopNavigation} />  useEffect(() => {

s.dependency "MapboxNavigationCore", :git => "https://github.com/mapbox/mapbox-navigation-ios.git", :tag => "v3.15.0"

s.dependency "MapboxNavigationUIKit", :git => "https://github.com/mapbox/mapbox-navigation-ios.git", :tag => "v3.15.0"      )}

````

    </View>    const navigationListener = MapboxNavigation.addListener('onNavigationStarted', () => {## Usage

## License

);

MIT
} setIsNavigating(true);

`````

    });```typescript

## API Reference

import MapboxNavigation from '../../modules/mapbox-navigation/src/MapboxNavigation';

### Methods

    const progressListener = MapboxNavigation.addListener('onRouteProgressChanged', (data) => {import type { Destination } from '../../modules/mapbox-navigation/src/MapboxNavigation';

#### `initialize(accessToken: string): Promise<void>`

Initializes the Mapbox Navigation SDK with your access token. console.log('Route progress:', data);

**Parameters:** });// Initialize Mapbox Navigation

- `accessToken`: Your Mapbox access token

await MapboxNavigation.initialize('your-access-token');

#### `startNavigation(destination: Destination): Promise<void>`

Starts turn-by-turn navigation to the specified destination. const arrivalListener = MapboxNavigation.addListener('onFinalDestinationArrival', () => {

**Parameters:** setIsNavigating(false);// Start navigation

- `destination`: Object with `latitude`, `longitude`, and optional `name`

  });const destination: Destination = {

#### `stopNavigation(): Promise<void>`

Stops the current navigation session. latitude: 52.3676,

#### `addListener(eventName: string, callback: Function): Subscription` return () => { longitude: 4.9041,

Adds an event listener for navigation events.

      navigationListener?.remove();  address: 'Amsterdam, Netherlands',

### Events

      progressListener?.remove();};

- `onNavigationStarted`: Fired when navigation begins

- `onRouteProgressChanged`: Fired during navigation with progress data arrivalListener?.remove();await MapboxNavigation.startNavigation(destination);

- `onFinalDestinationArrival`: Fired when reaching the destination

- `onNavigationCancelled`: Fired when navigation is cancelled };

### Types }, []);// Stop navigation

````typescriptawait MapboxNavigation.stopNavigation();

interface Destination {

  latitude: number;  const startNavigation = async () => {```

  longitude: number;

  name?: string;    try {

}

```      await MapboxNavigation.startNavigation({## Available Methods



## Platform Support        latitude: 37.7749,



- ✅ iOS (iOS 12.0+)        longitude: -122.4194,- `initialize(accessToken: string)`: Initialize Mapbox Navigation

- ❌ Android (not supported)

        name: "San Francisco"- `startNavigation(destination: Destination)`: Start navigation to destination

## Dependencies

      });- `stopNavigation()`: Stop current navigation

This package automatically installs the following CocoaPods dependencies:

    } catch (error) {- `getNavigationStatus()`: Get current navigation status

- `MapboxNavigation (~> 3.0)`

- `MapboxCoreNavigation (~> 3.0)`      console.error('Navigation error:', error);- `addNavigationListener(eventType, callback)`: Listen to navigation events

- `MapboxNavigationUI (~> 3.0)`

    }

## Requirements

  };## Events

- React Native >= 0.60.0

- iOS >= 12.0

- Xcode >= 12.0

- CocoaPods >= 1.10.0  const stopNavigation = async () => {- `navigationStatusChanged`: Fired when navigation status changes



## Troubleshooting    try {- `navigationError`: Fired when an error occurs



### Common Issues      await MapboxNavigation.stopNavigation();- `routeProgress`: Fired when route progress is updated



1. **Pod install fails**: Make sure you have the latest CocoaPods version      setIsNavigating(false);

2. **Mapbox SDK errors**: Verify your access token is valid and has the correct permissions

3. **Build errors**: Clean your project and try rebuilding    } catch (error) {## Platform Support



### Debug Steps      console.error('Stop navigation error:', error);



1. Check your Mapbox access token validity    }This module currently only supports iOS. Android will show a fallback message.

2. Ensure iOS deployment target is 12.0+

3. Run `pod install` in the ios directory  };

4. Clean and rebuild your project

## Troubleshooting

## License

  return (

MIT
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>1. **Module not found**: Make sure you've added the native files to Xcode and rebuilt

      <Text>Navigation Status: {isNavigating ? 'Active' : 'Inactive'}</Text>2. **Mapbox SDK not working**: Verify the SPM package is properly added and imports are uncommented

      3. **Build errors**: Check that all native files are added to the target and Mapbox SDK is properly configured

      {!isNavigating ? (4. **Authentication errors**: Verify your `.netrc` file is configured correctly with Downloads:Read scope token

        <Button title="Start Navigation" onPress={startNavigation} />
      ) : (
        <Button title="Stop Navigation" onPress={stopNavigation} />
      )}
    </View>
  );
}
`````

## API Reference

### Methods

#### `startNavigation(destination: Destination): Promise<void>`

Starts turn-by-turn navigation to the specified destination.

**Parameters:**

- `destination`: Object with `latitude`, `longitude`, and optional `name`

#### `stopNavigation(): Promise<void>`

Stops the current navigation session.

#### `addListener(eventName: string, callback: Function): Subscription`

Adds an event listener for navigation events.

### Events

- `onNavigationStarted`: Fired when navigation begins
- `onRouteProgressChanged`: Fired during navigation with progress data
- `onFinalDestinationArrival`: Fired when reaching the destination
- `onNavigationCancelled`: Fired when navigation is cancelled

## Platform Support

- ✅ iOS (iOS 12.0+)
- ❌ Android (not supported)

## Requirements

- React Native >= 0.60.0
- iOS >= 12.0
- Xcode >= 12.0

## License

MIT
