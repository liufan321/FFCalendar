Pod::Spec.new do |s|
  s.name         = "FFCalendar"
  s.version      = "0.0.1"
  s.summary      = "轻量级日历选择控件"
  s.homepage     = "https://github.com/liufan321/FFCalendar"
  s.license      = "MIT"
  s.author       = { "Fan Liu" => "liufan321@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/liufan321/FFCalendar.git", :tag => "#{s.version}" }
  s.source_files  = "FFCalendar", "FFCalendar/FFCalendarView/*.{h,m}"
  s.requires_arc = true
end
