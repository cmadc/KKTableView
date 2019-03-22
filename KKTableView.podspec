#
#  Be sure to run `pod spec lint KKRouter.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "KKTableView"
  s.version      = "0.0.8"
  s.summary      = "UITableView"

  s.description  = <<-DESC
                   对UITableView的封装
                   1.可以方便快速的使用tableview；
                   2.tableview模块化开发工具
                   DESC

  s.homepage     = "https://github.com/cmadc/KKTableView"
  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "caiming" => "davis_cai@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/cmadc/KKTableView.git", :tag => s.version }
  s.source_files  = "Classes", "Pod/*.{h,m}"
  s.requires_arc = true
  s.dependency 'KKRouter'
  s.dependency 'UITableView+FDTemplateLayoutCell'

end
