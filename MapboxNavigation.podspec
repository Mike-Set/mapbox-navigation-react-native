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
  s.homepage     = "https://github.com/sneleentaxi/S9I-Driver"
  s.license      = "MIT"
  s.authors      = { "Sneleentaxi" => "tech@sneleentaxi.nl" }
  s.platforms    = { :ios => "14.0" }
  s.source       = { :git => "https://github.com/sneleentaxi/", :commit => "main" }

  s.source_files = "ios/**/*.{h,c,cc,cpp,m,mm,swift}"
  s.requires_arc = true

  # Use React dependency that works with React Native projects
  s.dependency "React"
  
  # Note: Mapbox Navigation dependencies need to be added via git in the main project's Podfile
  # The user will need to add these lines to their Podfile:
  # pod 'MapboxNavigationCore', :git => 'https://github.com/mapbox/mapbox-navigation-ios.git', :tag => 'v3.12.1'
  # pod 'MapboxNavigationUIKit', :git => 'https://github.com/mapbox/mapbox-navigation-ios.git', :tag => 'v3.12.1'
  
  # Compiler flags for Mapbox
  s.compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1'
  s.xcconfig = {
    'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/MapboxNavigationCore" "$(PODS_ROOT)/MapboxNavigationUIKit"',
    'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/MapboxNavigationCore" "$(PODS_ROOT)/MapboxNavigationUIKit"'
  }
end