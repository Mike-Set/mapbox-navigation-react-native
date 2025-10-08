import { NativeModules, NativeEventEmitter, Platform } from 'react-native';

const LINKING_ERROR = [
  "The package 'mapbox-navigation-native' doesn't seem to be linked. Make sure:",
  '',
  Platform.select({ ios: "- You have run 'cd ios && pod install'", default: '' }),
  '- You rebuilt the app after installing the package',
  '- You are not using Expo Go',
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

type MapboxNavigationType = {
  initialize(accessToken: string): Promise<string>;
  startNavigation(destination: Destination): Promise<string>;
  stopNavigation(): Promise<string>;
  getNavigationStatus(): Promise<NavigationStatus>;
};

type NavigationEvent = {
  type: 'navigation_started' | 'navigation_stopped' | 'route_progress' | 'error';
  data?: unknown;
  error?: string;
};

const MapboxNavigationModule = (
  NativeModules.MapboxNavigation
    ? NativeModules.MapboxNavigation
    : new Proxy(
        {},
        {
          get: () => {
            throw new Error(LINKING_ERROR);
          },
        }
      )
) as MapboxNavigationType;

// Create event emitter for listening to native events
const eventEmitter =
  Platform.OS === 'ios' && NativeModules.MapboxNavigation
    ? new NativeEventEmitter(NativeModules.MapboxNavigation as never)
    : null;

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
   * Add event listener for navigation status changes
   */
  addNavigationListener(
    eventType: 'navigationStatusChanged' | 'navigationError' | 'routeProgress',
    listener: (event: NavigationEvent) => void
  ): () => void;
};

const MapboxNavigation: MapboxNavigation = {
  initialize: (accessToken: string) => MapboxNavigationModule.initialize(accessToken),
  startNavigation: (destination: Destination) => MapboxNavigationModule.startNavigation(destination),
  stopNavigation: () => MapboxNavigationModule.stopNavigation(),
  getNavigationStatus: () => MapboxNavigationModule.getNavigationStatus(),

  addNavigationListener: (eventType, listener) => {
    if (!eventEmitter) {
      // Event emitter not available on this platform
      return () => {};
    }

    const subscription = eventEmitter.addListener(eventType, listener);
    return () => subscription.remove();
  },
};

export type { Destination, NavigationStatus, NavigationEvent, MapboxNavigation };
export default MapboxNavigation;
