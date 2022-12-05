Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "iDenfySDK"
s.summary = "iDenfy IOS SDK"
s.requires_arc = true
# 2
s.version = "0.9.2"
# 3
s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
LICENSE
}
s.author = { "iDenfy" => "info@idenfy.com" }
s.homepage = "https://idenfy.com"
s.source = { :http => "https://s3-eu-west-1.amazonaws.com/sdk.builds/ios-sdk/0.9.2/iDenfySDKxcf.zip" }
s.framework = "UIKit"
s.dependency 'lottie-ios'
s.dependency 'ZIPFoundation', '0.9.11'

s.default_subspec = 'iDenfySDK'
s.subspec 'iDenfySDK' do |idenfySdk|
idenfySdk.xcconfig = { 'CLANG_MODULES_AUTOLINK' => 'YES', 'OTHER_LDFLAGS' => "-ObjC"}
idenfySdk.vendored_frameworks =['IdenfySDK/idenfyNFCReading.xcframework', 'IdenfySDK/iDenfySDK.xcframework',
'IdenfySDK/idenfycore.xcframework',
'IdenfySDK/idenfyviews.xcframework', 'IdenfySDK/OpenSSL.xcframework']
idenfySdk.preserve_paths = "IdenfyAssets/*"
end

s.subspec 'iDenfyLiveness' do |liveness|
liveness.xcconfig = { 'CLANG_MODULES_AUTOLINK' => 'YES', 'OTHER_LDFLAGS' => "-ObjC"}
liveness.preserve_paths = "IdenfyAssets/*"
liveness.vendored_frameworks = ['IdenfyLiveness/idenfyNFCReading.xcframework','IdenfyLiveness/FaceTecSDK.xcframework', 'IdenfyLiveness/iDenfySDK.xcframework', 'IdenfyLiveness/IdenfyLiveness.xcframework', 'IdenfyLiveness/idenfycore.xcframework',
'IdenfyLiveness/idenfyviews.xcframework', 'IdenfyLiveness/OpenSSL.xcframework']
end

s.subspec 'iDenfyRecognition' do |recognition|
recognition.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
recognition.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
recognition.xcconfig = { 'CLANG_MODULES_AUTOLINK' => 'YES', 'OTHER_LDFLAGS[sdk=iphoneos*]' => '-ObjC -l"idengine-ios"', 'OTHER_LDFLAGS[sdk=iphonesimulator*]' => '-ObjC -l"idengine-ios-simulator"' }
recognition.preserve_paths = "IdenfyAssets/*"
recognition.vendored_frameworks = ['IdenfyRecognition/idenfyNFCReading.xcframework','IdenfyRecognition/FaceTecSDK.xcframework', 'IdenfyRecognition/iDenfySDK.xcframework', 'IdenfyRecognition/IdenfyLiveness.xcframework', 'IdenfyRecognition/idenfycore.xcframework', 'IdenfyRecognition/idenfyviews.xcframework', 'IdenfyRecognition/idengine.xcframework', 'IdenfyRecognition/iDenfyDocRecognition.xcframework', 'IdenfyRecognition/OpenSSL.xcframework']
end

s.swift_version = "5.0"
end
