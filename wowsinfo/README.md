# WoWs Info

The root folder of WoWs Info containing iOS, Android and React Native.

## React Native

Read [this guide](https://reactnative.dev/docs/integration-with-existing-apps) to setup react native with existing apps. The better way is to be native first and use react native as a framework instead.

### IOS

React Native is now used as a module so the app is native first. Although the entire is in React Native, this way I can have full control over the native side.

#### Issues

- hermes needs to turn off or Xcode doesn't build
- SceneDelegate shouldn't be used now due to RedBox (see AppDelegate for more)
- `pod install` is required for native to find all react native modules
- remember to `npm start` to run the server
- link vector icons
