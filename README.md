# WoWs Info Origin
<img src="https://raw.githubusercontent.com/HenryQuan/WoWs-Info-Origin/master/WoWsInfo/ios/WoWsInfo/Images.xcassets/AppIcon.appiconset/_AppIcon_1024x1024.png" width="128px" height="128px" />

[中文]() | [English]() | [日本語]()

This is not the official app for [World of Warships](https://worldofwarships.com/). It is my own project and it is powered by [React Native](https://facebook.github.io/react-native/). It supports IOS, Android and [UWP](https://github.com/HenryQuan/WoWs-Info-Origin/tree/win10). Data are from [Wargaming API](https://developers.wargaming.net), [WoWs Numbers](http://wows-numbers.com) and [Global Wiki](https://wiki.wargaming.net/en/World_of_Warships).

# Technical insights
JSON based database (NoSQL) is used to store data. WoWs Info will only update data when the game updates. The way how I interact with data isn't ideal. I should have used Singeleton pattern to wrap global/static in a class. This way, I could prevent code duplication. You should always plan ahead. I spent two years working this project but I would have spent 2 months designing it and save a year but I didn't.

# Pro version
My admob account has been terminated due to some unknown reasons. Therefore, pro version is added to get some funds so that I could pay Apple annually. Without your support, it is unlikely that I will add more features and even update WoWs Info regularly.

# Run this project
- Setup [React Native](https://facebook.github.io/react-native/docs/getting-started) on your computer. Make sure you follow `React Native CLI Quickstart`.
- Clone WoWs Info to your computer
~~~~
git clone https://github.com/HenryQuan/WoWs-Info-Origin.git
~~~~
- Run the following commands to install package and run it on your Android devices (and it won't work)
~~~~
cd WoWs-Info-Origin
cd WoWsInfo 
npm install
react-native link
react-native run-android
~~~~
- You will need to get a key from [here](https://developers.wargaming.net) and create a file called `key.ts` inside 'WoWsInfo/src/value' folder with this line of code. Then, you can run WoWs Info on your devices.
~~~~
export const AppKey = 'PUT YOUR KEY HERE';
~~~~

If you don't want to pay for the pro version, you can change the source code and compile yourself. **However, it is prohibited to distribute your modified app elsewhere.** ~~(but what can I do if you don't listen...)~~

# Support WoWs Info
- Star this repository
- Share with your friends
- [Patreon](https://www.patreon.com/henryquan) | [PayPal](https://www.paypal.me/YihengQuan) | [WeChat](https://github.com/HenryQuan/WoWs-Info-Origin/blob/master/Support/WeChat.png) 
- [(IOS) App Store](https://itunes.apple.com/app/id1202750166) | [(Android) Google Play](https://play.google.com/store/apps/details?id=com.yihengquan.wowsinfo)
- Get pro version
