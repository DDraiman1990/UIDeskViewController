
Pod::Spec.new do |s|
  s.name             = 'UIDeskViewController'
  s.version          = '0.9.0'
  s.summary          = 'A simple Generic UITableViewController for iOS'

  s.description      = <<-DESC
  A simple Generic UITableViewController for iOS.
  UIDeskViewController supports an Array based table and an NSFetchResultsController table out of the box without the need to add a single line of code.
                       DESC

  s.homepage         = 'https://github.com/ddraiman1990/UIDeskViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ddraiman1990' => 'ddraiman1990@gmail.com' }
  s.source           = { :git => 'https://github.com/ddraiman1990/UIDeskViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'UIDeskViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UIDeskViewController' => ['UIDeskViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreData', 'UIKit'
  
  s.swift_version = '5.0'
  s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'Example/Tests/UnitTests/**/*'
  end
end
