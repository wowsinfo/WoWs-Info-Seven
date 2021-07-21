# WoWs Info

The root folder of WoWs Info containing iOS, Android and React Native.

## React Native

Read [this guide](https://reactnative.dev/docs/integration-with-existing-apps) to setup react native with existing apps. The better way is to be native first and use react native as a framework instead.

- [Communication between native and React Native](https://reactnative.dev/docs/communication-ios)
- [Native modules](https://reactnative.dev/docs/native-modules-intro)
- [Native components](https://reactnative.dev/docs/native-components-android)
- [Vector icons](https://oblador.github.io/react-native-vector-icons/)
- [Material icons](https://materialdesignicons.com/)

### IOS

React Native is now used as a module so the app is native first. Although the entire is in React Native, this way I can have full control over the native side.

#### Issues

- hermes needs to turn off or Xcode doesn't build
- SceneDelegate shouldn't be used now due to RedBox (see AppDelegate for more)
- `pod install` is required for native to find all react native modules
- remember to `npm start` to run the server
- link vector icons
- Sending `quick_action` with no listeners registered
  - https://stackoverflow.com/a/48716140
  - https://gist.github.com/brennanMKE/1ebba84a0fd7c2e8b481e4f8a5349b99
  - React Native will initilise the emitter so it needs to be injected to the singleton
- IMPORTANT
  - React Native always creates a new copy so Singleton won't work
    - A new instance can be created even if init is private (due to Obj-C signal)
  - A helper class needs to be used to inject to the Singleton
  - Do not use a class for both native and react native (it won't work)
