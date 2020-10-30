Pod::Spec.new do |s|

  s.name                = "PasswordWidgetFramework"
  s.version             = "1.0.0"
  s.summary             = "A password strength animation."
  s.description         = "A widget to use for password animations."
  s.homepage            = "http://github.com/LuqKhan"
  s.license             = "MIT"
  s.author              = "Luqmaan Khan"
  s.platform            = :ios, "13.0"
  s.source              = { :git => "https://github.com/LuqKhan/PasswordWidgetFramework.git", :tag => "1.0.0" }
  s.source_files        = "PasswordFieldWidget"
  s.swift_version       = "5.0"

end