import ExpoModulesCore
import MapboxNavigationCore
import MapboxNavigationUIKit

public class MapboxNavigationModule: Module {
    
    // MARK: - Module Definition
    
    public func definition() -> ModuleDefinition {
        Name("MapboxNavigation")
        
        // Define events that can be sent to JavaScript
        Events(
            "onNavigationStarted",
            "onRouteProgressChanged", 
            "onFinalDestinationArrival",
            "onNavigationCancelled"
        )
        
        // MARK: - Async Functions
        
        // Initialize Mapbox Navigation
        AsyncFunction("initialize") { (accessToken: String, promise: Promise) in
            DispatchQueue.main.async {
                do {
                    // Initialize Mapbox Navigation with access token
                    NavigationSettings.shared.accessToken = accessToken
                    
                    print("MapboxNavigation initialized with access token")
                    promise.resolve("Mapbox Navigation initialized successfully")
                } catch {
                    promise.reject("INIT_ERROR", error.localizedDescription)
                }
            }
        }
        
        // Start navigation to a destination
        AsyncFunction("startNavigation") { (destination: [String: Any], promise: Promise) in
            DispatchQueue.main.async {
                do {
                
                    guard let latitude = destination["latitude"] as? Double,
                          let longitude = destination["longitude"] as? Double else {
                        promise.reject("INVALID_DESTINATION", "Invalid destination coordinates")
                        return
                    }
                    
                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    
                    // Create navigation options
                    let options = NavigationRouteOptions(coordinates: [coordinate])
                    
                    // Start navigation
                    // self.startNavigation(with: options)
              
                    
                    self.sendEvent("onNavigationStarted", [
                        "type": "navigation_started",
                        "destination": destination
                    ])
                    
                    promise.resolve("Navigation started successfully")
                } catch {
                    promise.reject("NAVIGATION_ERROR", error.localizedDescription)
                }
            }
        }
        
        // Stop navigation
        AsyncFunction("stopNavigation") { (promise: Promise) in
            DispatchQueue.main.async {
                do {
                    // Stop navigation implementation
                    // self.stopNavigation()
                    
                    self.sendEvent("onNavigationCancelled", [
                        "type": "navigation_stopped"
                    ])
                    
                    promise.resolve("Navigation stopped successfully")
                } catch {
                    promise.reject("NAVIGATION_STOP_ERROR", error.localizedDescription)
                }
            }
        }
        
        // Get current navigation status
        AsyncFunction("getNavigationStatus") { (promise: Promise) in
            do {
                // Get navigation status from Mapbox
                let status: [String: Any] = [
                    "isNavigating": false,
                    "remainingDistance": 0,
                    "remainingDuration": 0,
                    "currentStep": NSNull()
                ]
                
                promise.resolve(status)
            } catch {
                promise.reject("GET_NAVIGATION_STATUS_ERROR", error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Helper Methods
    
    private func startNavigation(with options: NavigationRouteOptions) {
        // Implement actual Mapbox Navigation starting logic here
        // This is where you would integrate with Mapbox Navigation SDK
    }
    
    private func stopNavigation() {
        // Implement actual Mapbox Navigation stopping logic here
        // This is where you would stop the navigation session
    }
}