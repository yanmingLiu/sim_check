Pod::Spec.new do |s|
  s.name             = 'flutter_sim_check'
  s.version          = '0.0.2'
  s.summary          = 'Flutter plugin to detect SIM card presence and carrier info.'
  s.description      = <<-DESC
A new Flutter plugin to check SIM card presence and get carrier information on iOS and Android.
                       DESC
  s.homepage         = 'https://github.com/fluttercommunity/flutter_sim_check'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Flutter Community' => 'email@example.com' }
  
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end