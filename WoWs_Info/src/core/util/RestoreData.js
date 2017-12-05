import store from 'react-native-simple-store';
import { localDataName } from '../../constant/value';

export const restoreData = () => {
  return new Promise((success, failure) => {
    try {
      store.get(localDataName.currServer).then(server => {
        global.server = server;
      })
      store.get(localDataName.isPro).then(pro => {
        global.isPro = pro;
      })
      store.get(localDataName.hasAds).then(ad => {
        global.hasAds = ad;
      })
      store.get(localDataName.apiLanguage).then(api => {
        global.apiLanguage = api;
      })
      store.get(localDataName.appLanguage).then(app => {
        global.appLanguage = app;
      })
      store.get(localDataName.newsLanguage).then(news => {
        global.newsLanguage = news;
      })
      store.get(localDataName.themeColour).then(color => {
        global.themeColour = color;
      })
      store.get(localDataName.userInfo).then(info => {
        global.userInfo = info;
        success(true);
      })
    } catch (error) {
      console.error(error);
      failure(false);
    }
  })
}