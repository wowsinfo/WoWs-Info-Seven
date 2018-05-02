# WoWs Info
This is an unofficial app for the game [World of Warships](https://worldofwarships.com/). Its predecessor is [WoWs Info Swift](https://github.com/HenryQuan/WoWs_Info_Swift) but it is only available on IOS. This project aims to build a cross platform version of WoWs Info for IOS and Android. (Maybe UWP in the future)

## Features
* [ ] Search players and clans
  - [ ] Detailed statistics
  - [ ] [Personal Rating](https://wows-numbers.com/personal/rating)
* [x] Get lastest news
* [x] Wiki for World of Warships
  - [ ] Stats for all warships
* [ ] Your own player list
  - [ ] Star your friends and good players
  - [x] I am glad to play in a division
* [x] Check how many online players are online
* [x] Support all major servers
  - [ ] ASIA, EU, RU, NA (and maybe CN)
* [ ] Free and open source (but there is an IAP)
  - [ ] Windows 10 version is not free (but no IAP)
  - [ ] There might be a Mac version
* [x] Theme

Data will be saved locally for better performance and this project should be more stable than [WoWs Info Swift](https://github.com/HenryQuan/WoWs_Info_Swift).

## Dependencies
* [fast-html-parser](https://github.com/ashi009/node-fast-html-parser)
* [react](https://github.com/facebook/react)
* [react-native](https://github.com/facebook/react-native)
* [react-native-elements](https://github.com/react-native-training/react-native-elements)
* [react-native-tab-view](https://github.com/react-native-community/react-native-tab-view)
* [react-native-vector-icons](https://github.com/oblador/react-native-vector-icons)
* [util](https://github.com/expo/react-native-util)
* [react-localization](https://github.com/stefalda/react-localization)
* [react-native-device-info](https://github.com/rebeccahughes/react-native-device-info)
* [react-native-simple-store](https://github.com/jasonmerino/react-native-simple-store)
* [react-native-super-grid](https://github.com/saleel/react-native-super-grid)
* [react-native-userdefaults-ios](https://github.com/dsibiski/react-native-userdefaults-ios)
* [string-format](https://github.com/davidchambers/string-format)

Data are from [Wargaming API](https://developers.wargaming.net), [空中网](http://wows.kongzhong.com/) and [WoWs Numbers](http://wows-numbers.com).

## How to install it on my devices
~~~~
npm install
react-native link
react-native run-ios (run-android/run-windows)
~~~~
### IOS
It is available on [App Store]() but currently, it is the old build. Alternatively, you could clone this project and run it yourself.
### Android
[Releases](https://github.com/HenryQuan/React-Native-WoWs-Info/releases) are available now.
#### Google Play
Google Play | Github