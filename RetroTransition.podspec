#
# Be sure to run `pod lib lint Untagger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RetroTransition'
  s.version          = '0.0.5'
  s.summary          = 'Fun implementations of UIViewControllerAnimatedTransitioning for 90s inspired transitions between view controllers.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Fun implementations of UIViewControllerAnimatedTransitioning for 90s inspired transitions between view controllers. Convienence methods added to UINavigationController, but you RetroTransition implements UIViewControllerAnimatedTransitioning so you can use it directly if you wish.
                       DESC

  s.homepage         = 'https://github.com/wcgray/RetroTransition'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wcgray' => 'cam@tinsoldiersoftware.com' }
  s.source           = { :git => 'https://github.com/wcgray/RetroTransition.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'
  s.source_files = 'Sources/**/*.{swift,m,h}'
  s.public_header_files = 'Sources/*.h'
  s.module_name = 'RetroTransition'
  s.frameworks = 'Foundation'
end
