Pod::Spec.new do |s|
  s.name         =  'ILTranslucentView'
  s.version      =  '0.2'
  s.license      =  'MIT'
  s.summary      =  'ILTranslucentView is a little subclass of UIView that provide native iOS 7+ blur effect.' 
  s.description      =  'ILTranslucentView is a little subclass of UIView that provide native iOS 7+ blur (translucent) effect. It can be used on all iOS devices in real time without any performance problems. It also supports smooth UIView animation of color, frame, alpha etc.'
  s.author       =  { 'ivoleko' => 'https://github.com/ivoleko' }
  s.source       =  { :git => 'https://github.com/ivoleko/ILTranslucentView.git' , :tag => s.version }
  s.homepage     =  'https://github.com/ivoleko/ILTranslucentView'
  s.platform     =  :ios
  s.source_files =  'Source'
  s.requires_arc =  true
  s.ios.deployment_target = '7.0'
end
