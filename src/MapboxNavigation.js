"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const react_native_1 = require("react-native");
const LINKING_ERROR = [
    "The package 'mapbox-navigation-native' doesn't seem to be linked. Make sure:",
    '',
    react_native_1.Platform.select({ ios: "- You have run 'cd ios && pod install'", default: '' }),
    '- You rebuilt the app after installing the package',
    '- You are not using Expo Go',
].join('\n');
const MapboxNavigationModule = (react_native_1.NativeModules.MapboxNavigation
    ? react_native_1.NativeModules.MapboxNavigation
    : new Proxy({}, {
        get: () => {
            throw new Error(LINKING_ERROR);
        },
    }));
// Create event emitter for listening to native events
const eventEmitter = react_native_1.Platform.OS === 'ios' && react_native_1.NativeModules.MapboxNavigation
    ? new react_native_1.NativeEventEmitter(react_native_1.NativeModules.MapboxNavigation)
    : null;
const MapboxNavigation = {
    initialize: (accessToken) => MapboxNavigationModule.initialize(accessToken),
    startNavigation: (destination) => MapboxNavigationModule.startNavigation(destination),
    stopNavigation: () => MapboxNavigationModule.stopNavigation(),
    getNavigationStatus: () => MapboxNavigationModule.getNavigationStatus(),
    addNavigationListener: (eventType, listener) => {
        if (!eventEmitter) {
            // Event emitter not available on this platform
            return () => { };
        }
        const subscription = eventEmitter.addListener(eventType, listener);
        return () => subscription.remove();
    },
};
exports.default = MapboxNavigation;
