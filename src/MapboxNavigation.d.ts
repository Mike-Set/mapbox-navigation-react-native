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
type NavigationEvent = {
    type: 'navigation_started' | 'navigation_stopped' | 'route_progress' | 'error';
    data?: unknown;
    error?: string;
};
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
    addNavigationListener(eventType: 'navigationStatusChanged' | 'navigationError' | 'routeProgress', listener: (event: NavigationEvent) => void): () => void;
};
declare const MapboxNavigation: MapboxNavigation;
export type { Destination, NavigationStatus, NavigationEvent, MapboxNavigation };
export default MapboxNavigation;
