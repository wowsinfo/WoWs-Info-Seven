# WoWs Info Origin
This is not the official app for [World of Warships](https://worldofwarships.com/). It is my own project and it is powered by [React Native](https://facebook.github.io/react-native/). Data are from [Wargaming API](https://developers.wargaming.net), [WoWs Numbers](http://wows-numbers.com) and [Global Wiki](https://wiki.wargaming.net/en/World_of_Warships).

Note that UWP version is experimental. Some features are removed in order to make it work. It might not even have any updates. The only advantage of it is that RS works locally. Please download from Microsoft Store.

### Run this project
~~~~
cd WoWsInfo 
npm install
react-native link
react-native run-ios or react-native run-android
~~~~
You will need to get a key from [here](https://developers.wargaming.net) and create a file called 'key.js' inside 'WoWsInfo/src/value' folder with this line of code.
~~~~
export const AppKey = 'PUT YOUR KEY HERE';
~~~~

### Support WoWs Info
- Star this repository
- Share with your friends
- [Patreon](https://www.patreon.com/henryquan) / [PayPal](https://www.paypal.me/YihengQuan) / [WeChat](https://github.com/HenryQuan/WoWs-Info-Origin/blob/master/Support/WeChat.png) 
- [(IOS) App Store](https://itunes.apple.com/app/id1202750166)
- [(Android) Google Play](https://play.google.com/store/apps/details?id=com.yihengquan.wowsinfo)