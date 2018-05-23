Pod::Spec.new do |s|

  s.name         = 'ParknavSDK'
  s.version      = '1.0.0'
  s.swift_version = '4.0'
  s.summary      = 'Parknav Navigation SDK'
  s.description  = 'Parknav Navigation SDK provides turn-by-turn navigation to street parking'
  s.homepage     = 'https://parknav.com'
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { 'Sergei Kozyrenko' => 'sergei@parknav.com' }
  s.platform     = :ios, '10.0'

  s.source = { :http => 'https://github.com/parknav/sdk-ios-pod/blob/master/ParknavSDK.zip' }
  s.vendored_frameworks = 'ParknavSDK.framework'
  
  s.dependency 'Alamofire', '4.7.2'
  s.dependency 'MapboxNavigation', '0.17'
  s.dependency 'BrightFutures', '6.0.1'

end
