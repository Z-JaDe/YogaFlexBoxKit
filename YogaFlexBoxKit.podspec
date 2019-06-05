Pod::Spec.new do |s|
    s.name             = "YogaFlexBoxKit"
    s.version          = "1.0.0"
    s.summary          = "基于yoga的flex布局"
    s.description      = <<-DESC
    基于yoga的flex布局
    DESC
    s.homepage         = "https://github.com/Z-JaDe"
    s.license          = 'MIT'
    s.author           = { "ZJaDe" => "zjade@outlook.com" }
    s.source           = { :git => "git@github.com:Z-JaDe/YogaFlexBoxKit.git", :tag => s.version.to_s }
    
    s.requires_arc          = true
    
    s.ios.deployment_target = '9.0'
    s.frameworks            = "Foundation"
    s.swift_version         = "5.0"

    s.default_subspec = "Core"
    
    s.subspec "Core" do |ss|
      ss.source_files          = "Sources/**/*.{swift,h,m}"
      ss.dependency "Yoga"
    end
    
    s.subspec "ObjectiveC" do |ss|
      ss.dependency "YogaFlexBoxKit/Core"
        ss.source_files = "ObjectiveC/**/*.{swift,h,m}"
        ss.xcconfig = { 'OTHER_SWIFT_FLAGS' => '"-D" "ObjcSupport"' }
    end

end
