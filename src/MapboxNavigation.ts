import { NativeModule, requireNativeModule } from 'expo-modules-core';

const LINKING_ERROR = [
  "The package 'mapbox-navigation-react-native' doesn't seem to be linked. Make sure:",
  '',
  '- You have run npx expo install mapbox-navigation-react-native',
  '- You rebuilt the app after installing the package',
  '- You are using Expo Dev Client or a development build (not Expo Go)',
].join('\n');

type Destination = {
  latitude: number;
  longitude: number;
  address?: string;
};

type NavigationStatus = {
  isNavigating: boolean;
  remainingDistance: number;
  remainingDuration: number;
  currentStep: string | null;
};

interface MapboxNavigationNativeModule extends NativeModule {
  initialize(accessToken: string): Promise<string>;
  startNavigation(destination: Destination): Promise<string>;
  stopNavigation(): Promise<string>;
  getNavigationStatus(): Promise<NavigationStatus>;
}

type NavigationEvent = {
  type: 'navigation_started' | 'navigation_stopped' | 'route_progress' | 'error';
  data?: unknown;
  error?: string;
};

// Get the native module using Expo's requireNativeModule
const MapboxNavigationModule: MapboxNavigationNativeModule = (() => {
  try {
    return requireNativeModule('MapboxNavigation');
  } catch (error) {
    throw new Error(LINKING_ERROR);
  }
})();

export type MapboxNavigation = {
  /**
   * Initialize Mapbox Navigation with access token
   */
  initialize(accessToken: string): Promise<string>;

  /**
   * Start navigation to a destination using Mapbox
   */
  startNavigation(destination: Destination): Promise<string>;

  /**
   * Stop current navigation
   */
  stopNavigation(): Promise<string>;

  /**
   * Get current navigation status
   */
  getNavigationStatus(): Promise<NavigationStatus>;

  /**
   * Add event listener for navigation events
   */
  addListener(
    eventType: 'onNavigationStarted' | 'onRouteProgressChanged' | 'onFinalDestinationArrival' | 'onNavigationCancelled',
    listener: (event: NavigationEvent) => void
  ): { remove: () => void };
};

const MapboxNavigation: MapboxNavigation = {
  initialize: (accessToken: string) => MapboxNavigationModule.initialize(accessToken),
  startNavigation: (destination: Destination) => MapboxNavigationModule.startNavigation(destination),
  stopNavigation: () => MapboxNavigationModule.stopNavigation(),
  getNavigationStatus: () => MapboxNavigationModule.getNavigationStatus(),

  addListener: (eventType, listener) => {
    return MapboxNavigationModule.addListener(eventType, listener);
  },
};

export type { Destination, NavigationStatus, NavigationEvent, MapboxNavigation };
export default MapboxNavigation;
