source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.3'

target 'FZDJapp' do
#  inhibit_all_warnings!
#, :inhibit_warnings => true
  pod 'Masonry'
  pod 'SDWebImage'
  pod 'MBProgressHUD'
  pod 'SDCycleScrollView','~> 1.75'
  pod 'MJRefresh'
  pod 'GTMBase64'
  pod 'OpenUDID'
  pod 'MJExtension'
  pod 'YYText'
  pod 'WBHUDManager'
  
  pod 'UITableView+FDTemplateLayoutCell'
  pod 'PPNetworkHelper',:git => 'https://github.com/jkpang/PPNetworkHelper.git'

end

#消除"Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior"的警告
#清除xx is only available on iOS 8.0的警告
#清楚pod的警告
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF'] = 'NO'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
        end
    end
end
