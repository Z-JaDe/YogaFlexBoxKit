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
    
    s.ios.deployment_target = '13.0'
    s.swift_versions        = '5.0','5.1','5.2','5.3'
    s.frameworks            = "Foundation"

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
