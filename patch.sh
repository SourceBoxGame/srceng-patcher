echo "Setup Dependencies"
wget https://github.com/iBotPeaches/Apktool/releases/download/v2.8.1/apktool_2.8.1.jar
curl https://link.storjshare.io/s/jx64aidq7vah2sndcavivsw66apq/source-engine/source-engine-v1.16.0029.apk?download=1 -o base.apk
wget https://github.com/patrickfav/uber-apk-signer/releases/download/v1.3.0/uber-apk-signer-1.3.0.jar

echo "Extracting"
java -jar ./apktool_2.8.1.jar d base.apk -o ./extracted

echo "Patching"
cp -r ./lib/* ./extracted/lib
sed -i "s/Source Engine/$(cat config.json | jq .title -r)/g" ./extracted/res/values/strings.xml
sed -i "s/com.valvesoftware.source/$(cat config.json | jq .appid -r)/g" ./extracted/AndroidManifest.xml
sed -i "s/-console/$(cat config.json | jq .default_arguments -r)/g" ./extracted/smali/me/nillerusr/LauncherActivity.smali
sed -i "s/$(echo "/srceng")/$(cat config.json | jq .default_path -r)/g" ./extracted/smali/com/valvesoftware/ValveActivity2.smali
sed -i "s/hl2/$(cat config.json | jq .gamepath -r)/g" ./extracted/smali/com/valvesoftware/ValveActivity2.smali

mkdir -p ./extracted/res/drawable ./extracted/res/drawable-hdpi ./extracted/res/drawable-hdpi-v4 ./extracted/res/drawable-xhdpi ./extracted/res/drawable-xhdpi-v4 ./extracted/res/drawable-xxhdpi ./extracted/res/drawable-xxhdpi-v4 ./extracted/res/drawable-xxxhdpi ./extracted/res/drawable-xxxhdpi-v4

convert logo.png -resize 48x48 ./extracted/res/drawable/ic_launcher.png
convert logo.png -resize 72x72 ./extracted/res/drawable-hdpi/ic_launcher.png
convert logo.png -resize 72x72 ./extracted/res/drawable-hdpi-v4/ic_launcher.png
convert logo.png -resize 96x96 ./extracted/res/drawable-xhdpi/ic_launcher.png
convert logo.png -resize 96x96 ./extracted/res/drawable-xhdpi-v4/ic_launcher.png
convert logo.png -resize 144x144 ./extracted/res/drawable-xxhdpi/ic_launcher.png
convert logo.png -resize 144x144 ./extracted/res/drawable-xxhdpi-v4/ic_launcher.png
convert logo.png -resize 192x192 ./extracted/res/drawable-xxxhdpi/ic_launcher.png
convert logo.png -resize 192x192 ./extracted/res/drawable-xxxhdpi-v4/ic_launcher.png

echo "Packaging"
java -jar ./apktool_2.8.1.jar b ./extracted -o ./patched.apk
java -jar ./uber-apk-signer-1.3.0.jar -a ./patched.apk -o ./

echo "Cleanup"
rm -rf *.jar ./base.apk ./patched.apk ./extracted *.idsig
