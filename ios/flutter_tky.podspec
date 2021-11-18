#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_tky.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_tky'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin of talk_cloud sdk.'
  s.description      = <<-DESC
A new Flutter plugin of talk_cloud sdk.
                       DESC
  s.homepage         = 'https://github.com/xSILENCEx'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'l18281145312@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'

  s.vendored_frameworks = 'Libs/TKRoomSDK.framework', 'Libs/TKUISDK.framework', 'Libs/TKWhiteBoard.framework', 'Libs/ImSDK_Plus.framework'
  # s.vendored_libraries = 'Libs/TKRoomSDK.framework'
  # s.resource = 'Libs/TKRoomSDK.framework'

  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
 
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
