# 1. Create a .bitrise.secrets.yml file in bitrise_deployment directory
# 2. Add the following keys:
# envs:
# - BITRISE_DEPLOY_DIR: /Users/Viktas/Downloads/DEPLOY_DIR (zip file will be created here)
# - PROJECT_DIR: /Users/Viktas/Documents/ivs_ios (project directory)
# 3. Open terminal, cd bitrise_deployment directory
# 4. Run "bitrise run deploy" command in terminal

cd $PROJECT_DIR

# Create Frameworks
xcodebuild -workspace idenfySdk.xcworkspace -scheme iDenfyDocRecognition -configuration Release -derivedDataPath $PROJECT_DIR/../devices -sdk iphoneos ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="IDENFY_RECOGNITION" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme iDenfyDocRecognition -configuration Release -derivedDataPath $PROJECT_DIR/../simulators -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO EXCLUDED_ARCHS=i386 ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="IDENFY_RECOGNITION" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme idenfyviews -configuration Release -derivedDataPath $PROJECT_DIR/../devices -sdk iphoneos ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme idenfyviews -configuration Release -derivedDataPath $PROJECT_DIR/../simulators -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme idenfycore -configuration Release -derivedDataPath $PROJECT_DIR/../devices -sdk iphoneos ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme idenfycore -configuration Release -derivedDataPath $PROJECT_DIR/../simulators -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme idenfyNFCReading -configuration Release -derivedDataPath $PROJECT_DIR/../devices -sdk iphoneos ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme idenfyNFCReading -configuration Release -derivedDataPath $PROJECT_DIR/../simulators -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme IdenfyLiveness -configuration Release -derivedDataPath $PROJECT_DIR/../devices -sdk iphoneos ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme IdenfyLiveness -configuration Release -derivedDataPath $PROJECT_DIR/../simulators -sdk iphonesimulator ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme IdenfySDK -configuration Release -derivedDataPath $PROJECT_DIR/../devices -sdk iphoneos ONLY_ACTIVE_ARCH=NO ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode SWIFT_ACTIVE_COMPILATION_CONDITIONS="" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme IdenfySDK -configuration Release -derivedDataPath $PROJECT_DIR/../simulators -sdk iphonesimulator ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode ONLY_ACTIVE_ARCH=NO SWIFT_ACTIVE_COMPILATION_CONDITIONS="" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme IdenfySDK -configuration Release -derivedDataPath $PROJECT_DIR/../devices/liveness -sdk iphoneos ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode ONLY_ACTIVE_ARCH=NO SWIFT_ACTIVE_COMPILATION_CONDITIONS=IDENFY_LIVELINESS OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme IdenfySDK -configuration Release -derivedDataPath $PROJECT_DIR/../simulators/liveness -sdk iphonesimulator ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode ONLY_ACTIVE_ARCH=NO SWIFT_ACTIVE_COMPILATION_CONDITIONS=IDENFY_LIVELINESS OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme IdenfySDK -configuration Release -derivedDataPath $PROJECT_DIR/../devices/recognition -sdk iphoneos ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode ONLY_ACTIVE_ARCH=NO SWIFT_ACTIVE_COMPILATION_CONDITIONS="IDENFY_LIVELINESS IDENFY_RECOGNITION" OTHER_CFLAGS="-fembed-bitcode" clean archive

xcodebuild -workspace idenfySdk.xcworkspace -scheme IdenfySDK -configuration Release -derivedDataPath $PROJECT_DIR/../simulators/recognition -sdk iphonesimulator EXCLUDED_ARCHS=i386 ENABLE_BITCODE=NO BITCODE_GENERATION_MODE=bitcode ONLY_ACTIVE_ARCH=NO SWIFT_ACTIVE_COMPILATION_CONDITIONS="IDENFY_LIVELINESS IDENFY_RECOGNITION" OTHER_CFLAGS="-fembed-bitcode" clean archive

# Build Universal FAT frameworks
# mkdir $BITRISE_SOURCE_DIR/output
# ./fat_frameworks.sh -w idenfySdk.xcworkspace -o $BITRISE_SOURCE_DIR/output -c Release idenfyviews idenfycore idenfyNFCReading IdenfyLiveness IdenfySDK

# Create XCFrameworks
xcodebuild -create-xcframework \
    -framework $PROJECT_DIR/../devices/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphoneos/iDenfyDocRecognition.framework \
   -framework $PROJECT_DIR/../simulators/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphonesimulator/iDenfyDocRecognition.framework \
  -output $PROJECT_DIR/../output/iDenfyDocRecognition.xcframework

xcodebuild -create-xcframework \
    -framework $PROJECT_DIR/../devices/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphoneos/idenfyviews.framework \
   -framework $PROJECT_DIR/../simulators/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphonesimulator/idenfyviews.framework \
  -output $PROJECT_DIR/../output/idenfyviews.xcframework

xcodebuild -create-xcframework \
    -framework $PROJECT_DIR/../devices/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphoneos/IdenfyLiveness.framework \
   -framework $PROJECT_DIR/../simulators/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphonesimulator/IdenfyLiveness.framework \
  -output $PROJECT_DIR/../output/IdenfyLiveness.xcframework

xcodebuild -create-xcframework \
    -framework $PROJECT_DIR/../devices/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphoneos/idenfycore.framework \
   -framework $PROJECT_DIR/../simulators/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphonesimulator/idenfycore.framework \
  -output $PROJECT_DIR/../output/idenfycore.xcframework

xcodebuild -create-xcframework \
    -framework $PROJECT_DIR/../devices/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphoneos/idenfyNFCReading.framework \
   -framework $PROJECT_DIR/../simulators/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphonesimulator/idenfyNFCReading.framework \
  -output $PROJECT_DIR/../output/idenfyNFCReading.xcframework

xcodebuild -create-xcframework \
    -framework $PROJECT_DIR/../devices/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphoneos/iDenfySDK.framework \
   -framework $PROJECT_DIR/../simulators/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphonesimulator/iDenfySDK.framework \
  -output $PROJECT_DIR/../output/iDenfySDK.xcframework
  
xcodebuild -create-xcframework \
    -framework $PROJECT_DIR/../devices/liveness/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphoneos/iDenfySDK.framework \
   -framework $PROJECT_DIR/../simulators/liveness/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphonesimulator/iDenfySDK.framework \
  -output $PROJECT_DIR/../output/liveness/iDenfySDK.xcframework
  
  xcodebuild -create-xcframework \
    -framework $PROJECT_DIR/../devices/recognition/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphoneos/iDenfySDK.framework \
   -framework $PROJECT_DIR/../simulators/recognition/Build/Intermediates.noindex/ArchiveIntermediates/IdenfySDK/BuildProductsPath/Release-iphonesimulator/iDenfySDK.framework \
  -output $PROJECT_DIR/../output/recognition/iDenfySDK.xcframework

# Create structure
cp -R $PROJECT_DIR/FaceTecSDK.xcframework $PROJECT_DIR/../output
cp -R $PROJECT_DIR/iDenfyDocRecognition/documentrecognition/idengine.xcframework $PROJECT_DIR/../output
cp -R $PROJECT_DIR/OpenSSL.xcframework $PROJECT_DIR/../output
mkdir $PROJECT_DIR/../output/IdenfyAssets
cp -R $PROJECT_DIR/iDenfySDK/idenfyassets/strings $PROJECT_DIR/../output/IdenfyAssets
mkdir $PROJECT_DIR/../output/IdenfyAssets/V2
cp -R $PROJECT_DIR/idenfyviews/assets $PROJECT_DIR/../output/IdenfyAssets/V2
mv $PROJECT_DIR/../output/IdenfyAssets/strings $PROJECT_DIR/../output/IdenfyAssets/IdenfyStrings
mkdir $PROJECT_DIR/../SDK
cp -R $PROJECT_DIR/../output/IdenfyAssets $PROJECT_DIR/../SDK
mkdir $PROJECT_DIR/../SDK/IdenfySDK
cp -R $PROJECT_DIR/../output/iDenfySDK.xcframework $PROJECT_DIR/../SDK/IdenfySDK
cp -R $PROJECT_DIR/../output/idenfycore.xcframework $PROJECT_DIR/../SDK/IdenfySDK
cp -R $PROJECT_DIR/../output/idenfyviews.xcframework $PROJECT_DIR/../SDK/IdenfySDK
cp -R $PROJECT_DIR/../output/idenfyNFCReading.xcframework $PROJECT_DIR/../SDK/IdenfySDK
cp -R $PROJECT_DIR/../output/OpenSSL.xcframework $PROJECT_DIR/../SDK/IdenfySDK
mkdir $PROJECT_DIR/../SDK/IdenfyLiveness
cp -R $PROJECT_DIR/../output/IdenfyLiveness.xcframework $PROJECT_DIR/../SDK/IdenfyLiveness
cp -R $PROJECT_DIR/../output/idenfycore.xcframework $PROJECT_DIR/../SDK/IdenfyLiveness
cp -R $PROJECT_DIR/../output/idenfyviews.xcframework $PROJECT_DIR/../SDK/IdenfyLiveness
cp -R $PROJECT_DIR/../output/idenfyNFCReading.xcframework $PROJECT_DIR/../SDK/IdenfyLiveness
cp -R $PROJECT_DIR/../output/FaceTecSDK.xcframework $PROJECT_DIR/../SDK/IdenfyLiveness
cp -R $PROJECT_DIR/../output/OpenSSL.xcframework $PROJECT_DIR/../SDK/IdenfyLiveness
cp -R $PROJECT_DIR/../output/liveness/iDenfySDK.xcframework $PROJECT_DIR/../SDK/IdenfyLiveness
mkdir $PROJECT_DIR/../SDK/IdenfyRecognition
cp -R $PROJECT_DIR/../output/iDenfyDocRecognition.xcframework $PROJECT_DIR/../SDK/IdenfyRecognition
cp -R $PROJECT_DIR/../output/IdenfyLiveness.xcframework $PROJECT_DIR/../SDK/IdenfyRecognition
cp -R $PROJECT_DIR/../output/idenfycore.xcframework $PROJECT_DIR/../SDK/IdenfyRecognition
cp -R $PROJECT_DIR/../output/idenfyviews.xcframework $PROJECT_DIR/../SDK/IdenfyRecognition
cp -R $PROJECT_DIR/../output/idenfyNFCReading.xcframework $PROJECT_DIR/../SDK/IdenfyRecognition
cp -R $PROJECT_DIR/../output/FaceTecSDK.xcframework $PROJECT_DIR/../SDK/IdenfyRecognition
cp -R $PROJECT_DIR/../output/OpenSSL.xcframework $PROJECT_DIR/../SDK/IdenfyRecognition
cp -R $PROJECT_DIR/../output/recognition/iDenfySDK.xcframework $PROJECT_DIR/../SDK/IdenfyRecognition
cp -R $PROJECT_DIR/../output/idengine.xcframework $PROJECT_DIR/../SDK/IdenfyRecognition
# mkdir $PROJECT_DIR/../SDK/IdenfyLiveness-Legacy
# cp -R $PROJECT_DIR/output/IdenfyLiveness.framework $PROJECT_DIR/../SDK/IdenfyLiveness-Legacy
# cp -R $PROJECT_DIR/output/idenfycore.framework $PROJECT_DIR/../SDK/IdenfyLiveness-Legacy
# cp -R $PROJECT_DIR/output/idenfyviews.framework $PROJECT_DIR/../SDK/IdenfyLiveness-Legacy
# cp -R $PROJECT_DIR/output/idenfyNFCReading.framework $PROJECT_DIR/../SDK/IdenfyLiveness-Legacy
# cp -R $PROJECT_DIR/../output/FaceTecSDK.framework $PROJECT_DIR/../SDK/IdenfyLiveness-Legacy
# cp -R $PROJECT_DIR/output/iDenfySDK.framework $PROJECT_DIR/../SDK/IdenfyLiveness-Legacy
mv $PROJECT_DIR/../SDK $PROJECT_DIR/SDK

# Zip the directory
cd $PROJECT_DIR/SDK
zip -r $PROJECT_DIR/SDK *
mv $PROJECT_DIR/SDK.zip $PROJECT_DIR/iDenfySDKxcf.zip

rm -rf $PROJECT_DIR/SDK
rm -rf $PROJECT_DIR/../simulators
rm -rf $PROJECT_DIR/../devices
rm -rf $PROJECT_DIR/../output
rm -rf $PROJECT_DIR/../SDK
echo Setup is Done!
