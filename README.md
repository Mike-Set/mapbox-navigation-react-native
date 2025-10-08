# Mapbox Navigation React Native

A React Native wrapper for Mapbox Navigation v3 SDK (iOS only) that provides turn-by-turn navigation capabilities using CocoaPods with direct GitHub repository integration.

## Installation

```bash
npm install mapbox-navigation-react-native
# or
yarn add mapbox-navigation-react-native
```

For iOS, run:
```bash
cd ios && pod install
```

## Setup

### Prerequisites

1. **Mapbox Account & Access Token**
   - Sign up at [Mapbox](https://account.mapbox.com/)
   - Get your access token from the dashboard
   - Ensure your token has Navigation SDK permissions

2. **iOS Requirements**
   - iOS 12.0+
   - Xcode 12.0+
   - CocoaPods 1.10.0+

### Configuration

1. **Add your Mapbox token to your app configuration:**

```typescript
// app.config.ts (for Expo)
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
```

2. **CocoaPods Configuration**
   - Ensure your `ios/Podfile` has the minimum iOS version set to 12.0:
   ```ruby
   platform :ios, '12.0'
   ```

## Usage

```typescript
import React, { useEffect, useState } from 'react';
import { View, Text, Button } from 'react-native';
import MapboxNavigation from 'mapbox-navigation-react-native';

export default function NavigationScreen() {
  const [isNavigating, setIsNavigating] = useState(false);

  useEffect(() => {
    // Initialize Mapbox Navigation
    MapboxNavigation.initialize('YOUR_MAPBOX_ACCESS_TOKEN')
      .then(() => console.log('Mapbox Navigation initialized'))
      .catch((error) => console.error('Initialization error:', error));

    const navigationListener = MapboxNavigation.addListener('onNavigationStarted', () => {
      setIsNavigating(true);
    });

    const progressListener = MapboxNavigation.addListener('onRouteProgressChanged', (data) => {
      console.log('Route progress:', data);
    });

    const arrivalListener = MapboxNavigation.addListener('onFinalDestinationArrival', () => {
      setIsNavigating(false);
    });

    return () => {
      navigationListener?.remove();
      progressListener?.remove();
      arrivalListener?.remove();
    };
  }, []);

  const startNavigation = async () => {
    try {
      await MapboxNavigation.startNavigation({
        latitude: 37.7749,
        longitude: -122.4194,
        name: "San Francisco"
      });
    } catch (error) {
      console.error('Navigation error:', error);
    }
  };

  const stopNavigation = async () => {
    try {
      await MapboxNavigation.stopNavigation();
      setIsNavigating(false);
    } catch (error) {
      console.error('Stop navigation error:', error);
    }
  };

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text>Navigation Status: {isNavigating ? 'Active' : 'Inactive'}</Text>
      {!isNavigating ? (
        <Button title="Start Navigation" onPress={startNavigation} />
      ) : (
        <Button title="Stop Navigation" onPress={stopNavigation} />
      )}
    </View>
  );
}
```

## API Reference

### Methods

#### `initialize(accessToken: string): Promise<void>`

Initializes the Mapbox Navigation SDK with your access token.

**Parameters:**
- `accessToken`: Your Mapbox access token

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

### Types

```typescript
interface Destination {
  latitude: number;
  longitude: number;
  name?: string;
}
```

## Platform Support

- ✅ iOS (iOS 12.0+)
- ❌ Android (not supported)

## Dependencies

This package automatically installs the following dependencies directly from the Mapbox Navigation iOS repository:

- `MapboxNavigationCore` (v3.12.1+) from `https://github.com/mapbox/mapbox-navigation-ios.git`
- `MapboxNavigationUIKit` (v3.12.1+) from `https://github.com/mapbox/mapbox-navigation-ios.git`

### Why GitHub Repository Integration?

- ✅ **Always up-to-date**: Gets the latest compatible version directly from Mapbox
- ✅ **Reliable dependency resolution**: Avoids CocoaPods spec repository issues
- ✅ **Version locking**: Uses specific tag (v3.12.1) for stability
- ✅ **Better compatibility**: Ensures React Native works well with the exact Mapbox version

## Requirements

- React Native >= 0.60.0
- iOS >= 12.0
- Xcode >= 12.0
- CocoaPods >= 1.10.0

## Troubleshooting

### Common Issues

1. **Pod install fails**:
   - Make sure you have the latest CocoaPods version
   - Clear CocoaPods cache: `pod cache clean --all`
   - Delete `Podfile.lock` and `Pods/` directory, then run `pod install`

2. **Mapbox SDK errors**:
   - Verify your access token is valid and has the correct permissions
   - Check that your access token supports Navigation SDK

3. **Build errors**:
   - Clean your project and try rebuilding
   - Make sure iOS deployment target is 12.0+
   - Verify Xcode version compatibility

### Debug Steps

1. Check your Mapbox access token validity
2. Ensure iOS deployment target is 12.0+
3. Run `pod install --repo-update` to update pod repositories
4. Clean and rebuild your project:
   ```bash
   cd ios && rm -rf build && cd ..
   npx expo run:ios --device
   ```
5. Check that GitHub repository is accessible (network connectivity)

## Advanced Configuration

### Custom Mapbox Version

If you need a specific version of Mapbox Navigation, you can fork this package and modify the podspec:

```ruby
s.dependency "MapboxNavigationCore", :git => "https://github.com/mapbox/mapbox-navigation-ios.git", :tag => "v3.15.0"
s.dependency "MapboxNavigationUIKit", :git => "https://github.com/mapbox/mapbox-navigation-ios.git", :tag => "v3.15.0"
```

## License

MIT