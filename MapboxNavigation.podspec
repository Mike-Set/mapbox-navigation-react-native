require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "MapboxNavigation"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  A React Native bridge for Mapbox Navigation SDK v3, providing turn-by-turn navigation,
                  route progress tracking, and navigation events for iOS applications. This wrapper
                  integrates seamlessly with React Native projects using CocoaPods.
                   DESC
  s.homepage     = "https://github.com/Mike-Set/mapbox-navigation-react-native"
  s.license      = "MIT"
  s.authors      = { "Sneleentaxi" => "tech@sneleentaxi.nl" }
  s.platforms    = { :ios => "14.0" }
  s.swift_versions = ['5.0']
  s.source       = { :git => "https://github.com/Mike-Set/mapbox-navigation-react-native.git", :tag => "v#{s.version}" }
  
  # Explicitly specify source files only - no npm dependencies
  s.source_files = "ios/**/*.{h,m,mm,swift}"
  s.requires_arc = true

  # React Native dependencies - note that validation may require React Native context
  s.dependency "React-Core"
  
  # Note: Mapbox Navigation dependencies need to be added via git in the main project's Podfile
  # The user will need to add these lines to their Podfile:
  # pod 'MapboxNavigationCore', :git => 'https://github.com/mapbox/mapbox-navigation-ios.git', :tag => 'v3.12.1'
  # pod 'MapboxNavigationUIKit', :git => 'https://github.com/mapbox/mapbox-navigation-ios.git', :tag => 'v3.12.1'
  
  # Compiler flags for Mapbox
  s.compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1'
  s.xcconfig = {
    'HEADER_SEARCH_PATHS' => '$(inherited) "$(PODS_ROOT)/React-Core" "$(PODS_ROOT)/React-Core/React" "$(PODS_ROOT)/MapboxNavigationCore" "$(PODS_ROOT)/MapboxNavigationUIKit"',
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PODS_ROOT)/MapboxNavigationCore" "$(PODS_ROOT)/MapboxNavigationUIKit"'
  }
end