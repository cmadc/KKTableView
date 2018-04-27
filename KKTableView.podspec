#
#  Be sure to run `pod spec lint KKRouter.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  
  s.name         = "KKTableView"
  s.version      = "0.0.1"
  s.summary      = "router."

  s.description  = <<-DESC
                   A longer description of router in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/cmadc/KKTableView"
  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "caiming" => "davis_cai@163.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/cmadc/KKTableView.git", :tag => s.version }
  s.source_files  = "Classes", "Pod/*.{h,m}"
  s.requires_arc = true
  s.dependency 'KKRouter'
  s.dependency 'UITableView+FDTemplateLayoutCell'

end
