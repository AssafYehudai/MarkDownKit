#
# Be sure to run `pod lib lint MarkDownKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ChatyMarkDownKit'
  s.version          = '0.3.0'
  s.summary          = 'MarkDownKit is a kit allowing you to use markdown notation in your apps, on iOS and macOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    MarkDownKit Uses NSAttributedString to apply markDown featurs on text.
    You can use it for chatting apps for example.
    At the moment the kit marks *Bold* , _Italic_ and `code`.
                       DESC

  s.homepage         = 'https://github.com/AssafYehudai/MarkDownKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AssafYehudai' => 'assaf.yehudai@gmail.com' }
  s.source           = { :git => 'https://github.com/AssafYehudai/MarkDownKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'

  s.source_files = 'MarkDownKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MarkDownKit' => ['MarkDownKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
