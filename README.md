# WoWs Info
This is an unofficial app for the game [World of Warships](https://worldofwarships.com/). Its predecessor is [WoWs Info Swift](https://github.com/HenryQuan/WoWs_Info_Swift) but it is only available on IOS. This project aims to build a cross platform version of WoWs Info for IOS, Android, Windows 10 (and maybe Mac OS).

This app will be published on AppStore, Google Play and Microsoft Store. However, you are welcomed to play with the source code and run it on your own devices.

**Please do NOT abuse my Wargaming developer id** and get your own ID [here](https://developers.wargaming.net). If you may, please support me with IAP and Ads.

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

Data will be saved locally for better performance and this project should be more stable than WoWs Info Swift. (However, I found out that some Android devices could not save data to its storage and I have not found any solutions yet)

## Dependencies
* [fast-html-parser](https://github.com/ashi009/node-fast-html-parser)
* [react](https://github.com/facebook/react)
* [react-native](https://github.com/facebook/react-native)
* [react-native-elements](https://github.com/react-native-training/react-native-elements)
* [react-native-router-flux](https://github.com/aksonov/react-native-router-flux)
* [react-native-tab-view](https://github.com/react-native-community/react-native-tab-view)
* [react-native-vector-icons](https://github.com/oblador/react-native-vector-icons)
* [util](https://github.com/expo/react-native-util)
* [react-localization](https://github.com/stefalda/react-localization)
* [react-native-device-info](https://github.com/rebeccahughes/react-native-device-info)
* [react-native-modal-dropdown](https://github.com/sohobloo/react-native-modal-dropdown)
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
Google Play
#### Github
### Windows 10
Coming soon...
### Mac OS
Coming not so soon...

## IAP
- Remove all ads
- Show main account on launch
- Check player stat inside clan
- Check player clan inside player info
- Pro logo

|  IOS | Android | Windows 10 | Mac |
|:----:|:-------:|:----------:|:----:|
| 2.99 USD |   1.99 USD |     N/A  | N/A |

Windows 10 and Mac version will be paid so it does not have any ads and IAP. The price for them are 0.99 USD and 1.99 USD respectively.