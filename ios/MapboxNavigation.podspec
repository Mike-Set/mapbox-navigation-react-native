require "json"

package = JSON.parse(File.read(File.join(__dir__, "..", "package.json")))

Pod::Spec.new do |s|
  s.name         = "MapboxNavigation"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  An Expo Native Module for Mapbox Navigation SDK v3, providing turn-by-turn navigation,
                  route progress tracking, and navigation events for iOS applications. This wrapper
                  integrates seamlessly with Expo projects using ExpoModulesCore.
                   DESC
  s.homepage     = "https://github.com/Mike-Set/mapbox-navigation-react-native"
  s.license      = "MIT"
  s.authors      = { "Sneleentaxi" => "tech@sneleentaxi.nl" }
  s.platforms    = { :ios => "13.0" }
  s.swift_versions = ['5.4']
  s.source       = { :git => "https://github.com/Mike-Set/mapbox-navigation-react-native.git", :tag => "v#{s.version}" }  
  
  # Swift source files for Expo Native Module
  s.source_files = "*.{swift}"
  s.requires_arc = true

  s.dependency "ExpoModulesCore"
  
  # Expo Module configuration
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES'
  }
  
  # Compiler settings for Mapbox and Expo
  s.compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1'
end