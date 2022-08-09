# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end

target 'BRJM-iOS' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BRJM-iOS
  pod 'Alamofire'                  , '~> 5.2'
  pod 'ReactorKit'                 , '2.0.1'
  pod 'RxSwift'                    , '~> 5'
  pod 'RxCocoa'                    , '~> 5'
  pod 'RxGesture'                  , '3.0.0'
  pod 'RxKeyboard'                 , '1.0.0'
  pod 'RxDataSources'              , '4.0.1'
  pod 'RxOptional'                 , '4.0.0'
  pod 'RxAlamofire'                , '~> 5'

  pod 'SwiftyUserDefaults'         , '~> 5.0'
  pod 'IQKeyboardManagerSwift'     , '6.5.0'
  pod 'SwiftyJSON'
  pod 'RxRetroSwift'

  # image
  pod 'Nuke'                       , '~> 10.0'
  pod 'lottie-ios'
  pod 'APNGKit'                    , '~> 1.0'
    
  pod 'CHIPageControl', '~> 0.1.3'
  pod 'ViewPager-Swift'#Page Indicator
  pod 'MaterialDesignWidgets'
  #pod 'MaterialComponents'
  #pod 'MaterialComponents/FlexibleHeader'
  #pod 'MaterialComponents/Snackbar'
  pod 'MaterialComponents/BottomSheet'
  #pod 'MaterialComponents/Ink'
  pod 'TweeTextField'
    
  pod 'DeviceKit', '~> 4.0'
  pod 'PullToDismiss', '~> 2.2'

end
