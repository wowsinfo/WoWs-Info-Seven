<div align="center">
<img src="https://raw.githubusercontent.com/HenryQuan/WoWs-Info-Origin/master/WoWsInfo/ios/WoWsInfo/Images.xcassets/AppIcon.appiconset/_AppIcon_1024x1024.png" width="128px" height="128px" />
<h1>WoWs Info 起源</h1>

[中文](https://github.com/HenryQuan/WoWs-Info-Re/blob/master/README_zh.md) | [English](https://github.com/HenryQuan/WoWs-Info-Re/blob/master/README.md) | [日本語](https://github.com/HenryQuan/WoWs-Info-Re/blob/master/README_ja.md)

WoWs Info 并不是[战舰世界](https://worldofwarships.com/)的官方应用软件。她是我的个人项目，使用 [React Native](https://facebook.github.io/react-native/) 开发完成。目前支持 IOS、安卓、[UWP](https://github.com/HenryQuan/WoWs-Info-Origin/tree/win10)。数据来自 [Wargaming 服务器](https://developers.wargaming.net)、[WoWs Numbers](http://wows-numbers.com)、 [Global Wiki](https://wiki.wargaming.net/en/World_of_Warships).
</div>

# 技术上的一些小见解
数据是通过 JSON 来保存的。更新周期跟随游戏或者每周更新。目前数据的交互并不完美而且有很多重复的代码。我应该花两个月认真的设计 WoWs Info 来节省一年的时间而不是直接开始写代码。

*但是这些问题都会在 WoWs Info 的下一个大更新 [WoWs Info RE](https://github.com/HenryQuan/WoWs-Info-Re/tree/WoWs-Info-Re) 中修复/改进。*

# 关于专业版
**两年前**、我的 Admob 账号不知什么原因被谷歌永久封禁。专业版是用来继续维持 WoWs Info 的开发和维护。没有大家的支持，新功能的开发甚至正常的更新都将会终止（真的没有办法）。

专业版的价格是每年3美元（大概20元），会在1.0.7.1更新中加入。因为新的版本还在开发中，*直到 WoWs Info RE 更新之前，所有用户都可以享受半价优惠。*

# 如何运行 WoWs Info
- 在电脑上设置 [React Native](https://facebook.github.io/react-native/docs/getting-started)，请务必查看 `React Native CLI Quickstart` 教程
- 将 WoWs Info Clone 到电脑上
~~~~
git clone https://github.com/HenryQuan/WoWs-Info-Origin.git
~~~~
- 使用下面的指令来安装 Module 并且在 IOS 设备上运行（但是运行不会成功）
~~~~
cd WoWsInfo 
yarn
cd ios
pod install
cd ..
react-native run-ios
~~~~
- 你需要从[这里](https://developers.wargaming.net)获得一个钥密然后在 'WoWsInfo/src/value' 文件夹下创建 'key.js' 文件并且需要把下面的代码写到文件里面。保存之后，即可正常运行。
~~~~
export const AppKey = '<Your Key>';
~~~~

如果你不想购买专业版，你可以自己修改源代码并且编译。**但是，你不可以把修改过的软件分享给别人。**

# Support WoWs Info
- 给这个 Repo 一颗星
- 分享 WoWs Info 给朋友
- [Patreon](https://www.patreon.com/henryquan) | [贝宝](https://www.paypal.me/YihengQuan) | [微信](https://github.com/HenryQuan/WoWs-Info-Origin/blob/master/Support/WeChat.png) 
- [(IOS) 苹果应用商店](https://itunes.apple.com/app/id1202750166) | [(安卓) Google Play](https://play.google.com/store/apps/details?id=com.yihengquan.wowsinfo)
- 升级到专业版
