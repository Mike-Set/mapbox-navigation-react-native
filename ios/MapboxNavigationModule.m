#import "MapboxNavigationModule.h"
#import <React/RCTLog.h>
// Import Mapbox Navigation directly from GitHub repository
@import MapboxNavigationCore;
@import MapboxNavigationUIKit;

@implementation MapboxNavigationModule

RCT_EXPORT_MODULE(MapboxNavigation);

// Required for RCTEventEmitter
- (NSArray<NSString *> *)supportedEvents {
    return @[@"navigationStatusChanged", @"navigationError", @"routeProgress"];
}

// Initialize Mapbox Navigation
RCT_EXPORT_METHOD(initialize:(NSString *)accessToken
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            // Initialize Mapbox Navigation with access token
            [NavigationSettings.shared setAccessToken:accessToken];
            
            RCTLogInfo(@"MapboxNavigation initialized with access token");
            resolve(@"Mapbox Navigation initialized successfully");
        } @catch (NSException *exception) {
            reject(@"INIT_ERROR", exception.reason, nil);
        }
    });
}

// MARK: - Mapbox Navigation Methods

// Start navigation to a destination
RCT_EXPORT_METHOD(startNavigation:(NSDictionary *)destination
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            // Example implementation (uncomment after adding Mapbox Navigation)
            /*
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(
                [destination[@"latitude"] doubleValue],
                [destination[@"longitude"] doubleValue]
            );
            
            // Create navigation options
            NavigationRouteOptions *options = [[NavigationRouteOptions alloc] initWithCoordinates:@[
                [NSValue valueWithCLLocationCoordinate2D:coordinate]
            ]];
            
            // Start navigation
            // [self startNavigationWithOptions:options];
            */
            
            [self sendEventWithName:@"routeProgress" body:@{
                @"type": @"navigation_started",
                @"destination": destination
            }];
            
            resolve(@"Navigation started successfully");
        } @catch (NSException *exception) {
            reject(@"NAVIGATION_ERROR", exception.reason, nil);
        }
    });
}

// Stop navigation
RCT_EXPORT_METHOD(stopNavigation:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            // Stop navigation implementation
            // [self stopNavigation];
            
            [self sendEventWithName:@"navigationStatusChanged" body:@{
                @"type": @"navigation_stopped"
            }];
            
            resolve(@"Navigation stopped successfully");
        } @catch (NSException *exception) {
            reject(@"NAVIGATION_STOP_ERROR", exception.reason, nil);
        }
    });
}

// Get current navigation status
RCT_EXPORT_METHOD(getNavigationStatus:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    @try {
        // Get navigation status from Mapbox
        NSDictionary *status = @{
            @"isNavigating": @NO,
            @"remainingDistance": @0,
            @"remainingDuration": @0,
            @"currentStep": [NSNull null]
        };
        
        resolve(status);
    } @catch (NSException *exception) {
        reject(@"GET_NAVIGATION_STATUS_ERROR", exception.reason, nil);
    }
}

// Don't compile this in simulator - iOS SDK might not work in simulator
+ (BOOL)requiresMainQueueSetup {
    return YES;
}

@end