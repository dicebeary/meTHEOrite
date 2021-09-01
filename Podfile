platform :ios, '13.0'

workspace 'Metheorite'
project 'Core/Core.xcodeproj'
project 'Domain/Domain.xcodeproj'
project 'Metheorite.xcodeproj'

use_frameworks!
use_modular_headers!
inhibit_all_warnings!

target 'Core' do
  project 'Core/Core.xcodeproj'
  pod 'Alamofire'
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  pod 'Moya/RxSwift', '~> 14.0'
  pod 'Resolver', '1.4.3'
  pod 'SwiftSpinner', '2.2.0'

  target 'CoreTests' do
    pod 'SwiftyMocky', '4.0.4'
    pod 'RxBlocking', '~> 5.0'
    pod 'RxTest', '~> 5.0'
    pod 'Nimble', '9.0.0'
  end
end

target 'Domain' do
  project 'Domain/Domain.xcodeproj'
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'

  target 'DomainTests' do
    pod 'SwiftyMocky', '4.0.4'
  end
end

target 'Metheorite' do
  project 'Metheorite.xcodeproj'
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  pod 'RxDataSources', '~> 4.0'
  pod 'Kingfisher', '6.3.0'
  pod 'Moya/RxSwift', '~> 14.0'
  pod 'Resolver', '1.4.3'
  pod 'SwiftGen', '6.4.0'
  pod 'SwiftSpinner', '2.2.0'

  target 'MetheoriteTests' do
    pod 'SwiftyMocky', '4.0.4'
    pod 'RxBlocking', '~> 5.0'
    pod 'RxTest', '~> 5.0'
    pod 'Nimble', '9.0.0'
  end

end
