Pod::Spec.new do |s|
  s.name             = 'CocoaTweener'
  s.version          = '1.0.1'
  s.summary          = 'Animation engine for iOs, make more powerfull and creative Apps.'
  s.homepage         = 'https://github.com/alexrvarela/CocoaTweener'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'alexrvarela' => 'https://github.com/alexrvarela' }
  s.source           = { :git => 'https://github.com/alexrvarela/CocoaTweener.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/alexrvarela'
  s.ios.deployment_target = '8.0'
  s.source_files = 'Source/*.{h,m}'
end
