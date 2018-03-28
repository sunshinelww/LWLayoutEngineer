#
# Be sure to run `pod lib lint LWLayoutEngineer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LWLayoutEngineer'
  s.version          = '0.1.0'
  s.summary          = 'A short description of LWLayoutEngineer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/13517248639@163.com/LWLayoutEngineer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '13517248639@163.com' => '13517248639@163.com' }
  s.source           = { :git => 'https://github.com/13517248639@163.com/LWLayoutEngineer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.subspec 'Core' do |core|
      core.public_header_files = [
        'LWLayoutEngineer/Classes/CoreSource/YogaCore/*.h',
        'LWLayoutEngineer/Classes/CoreSource/YogaKit/*.h',
      ]
      core.source_files = 'LWLayoutEngineer/Classes/CoreSource/**/*.{h,c,m}'
  end

  s.subspec 'Base' do |base|
  	base.public_header_files = 'LWLayoutEngineer/Classes/Base/*.h'
  	base.source_files = 'LWLayoutEngineer/Classes/Base/*.{h,c,m}'
  end
  
  # s.resource_bundles = {
  #   'LWLayoutEngineer' => ['LWLayoutEngineer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
