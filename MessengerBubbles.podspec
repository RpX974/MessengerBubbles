Pod::Spec.new do |s|
    s.name                      = "MessengerBubbles"
    s.version                   = "0.1.0"
    s.summary                   = "Create Image views for user or group like Messenger"
    s.homepage                  = "https://github.com/RpX974/MessengerBubbles"
    s.license                   = { :type => 'MIT', :file => 'LICENSE' }
    s.author                    = { 'Laurent Grondin' => 'laurent.grondin@epitech.eu' }
    s.source                    = { :git => "https://github.com/RpX974/MessengerBubbles.git", :tag => s.version.to_s }
    s.ios.deployment_target     = "10.0"
    s.source_files              = 'MessengerBubbles/Classes/**/*'
    s.frameworks                = "Foundation"
    s.dependency 'Kingfisher', '~> 5.0'
    s.swift_version             = "5.0"
end
