Pod::Spec.new do |s|
  s.name         = "PlaceKit"
  s.version      = "0.0.1"
  s.summary      = "Placeholders, lorem ipsum, and random data oh my!"
  s.description  = "A placeholder and random data framework for all of your early-development and prototyping work."
  s.homepage     = "https://github.com/larsacus/PlaceKit"
  s.license      = {
    :type => 'MIT',
    :file => 'LICENSE'
  }
  s.author       = { "Lars Anderson" => "iAm@theonlylars.com" }
  s.source       = {
    :git => "https://github.com/larsacus/PlaceKit.git",
    :tag => s.version.to_s
  }
  s.platform     = :ios, '5.0'
  s.exclude_files = 'Demo'
  s.requires_arc = true
  s.default_subspec = 'Core'

  s.subspec 'Core' do |core|
    core.source_files = 'PlaceKit/PlaceKit.{h,m}'
  end
  
  s.subspec 'ImageView' do |iv|
    iv.source_files = 'PlaceKit/UIImageView+PlaceKit.{h,m}'
    iv.dependency 'PlaceKit/Core'
    iv.dependency 'AFNetworking', '~> 1.0'
  end
end
