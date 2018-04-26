# Uncomment this line to define a global platform for your project
# platform :ios, '8.0'
# Uncomment this line if you're using Swift
# use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

# 图片缓存
#pod 'SDWebImage', '4.2.2'
#pod 'SDWebImage/WebP'
#pod 'SDWebImage/GIF'


target 'ClipImage' do

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end 
end
