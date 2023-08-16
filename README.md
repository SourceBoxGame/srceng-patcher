# srceng-patcher
Simple, configurable and easy-to-use patching script for existing srceng-mod-launcher `.apk`s

# Why?
We were just too dump to figure out how build the app ourselves ¯\_(ツ)_/¯.

# How to use
Simply fork this repo, put your mods libraries in `lib/` and change `config.json` and `logo.png` files to your liking. Then run `patch.sh` shell script. `patch.sh` automatically downloads APKTool, official version of Source Engine launcher from nillerusr and Uber APK Patcher and removes them afterwards.

# Example use cases
- GitHub Actions/CI
You can `git clone` your fork from your main repo with engine code and set it as your prefix for both `armeabi-v7a-hard` and `aarch64` builds. Then, once both builds finished, you can `cd` into the directory you cloned to and run `patch.sh`. After all that you'll get `patched-aligned-debugSigned.apk` file. That's the final `.apk` you can publish. Don't mind the `debugSigned` part, it install just fine and doesn't cause any issues

# TODO
- Ability to change default asset patch
