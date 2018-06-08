import { Navigation } from 'react-native-navigation';
import { Platform, Alert, Dimensions } from 'react-native';
import { AdMobInterstitial } from 'react-native-admob';
import { registerScreens } from '../screen';

import { Blue, Green, Red, RED, BLUE, GREEN } from 'react-native-material-color';
import { getTextColour, statusBarColour, navStyle } from '../constant/colour';

import language from '../constant/language';
import { iconsLoaded, iconsMap } from '../constant/icon';
import { DataStorage } from '../core';

AdMobInterstitial.setAdUnitID('ca-app-pub-5048098651344514/7499671184');
AdMobInterstitial.setTestDevices([AdMobInterstitial.simulatorId]);

// Loading icons
iconsLoaded.then(() => {
  // Load data
  registerScreens();
  loadingData();   
});

/**
 * Loading data screen
 */
export function loadingData() {
  Navigation.startSingleScreenApp({
    screen: {
      screen: 'app.wowsinfo',
      navigatorStyle: {
        navBarHidden: true,
        statusBarTextColorScheme: 'light',
        statusBarColor: BLUE[700], 
      },
    },      
    animationType: 'none'
  });
}

/**
 * Start this application
 */
export function startApp() {
  hapticFeedback();
  android ? startAppAndroid() : startAppIOS(); 
}

/**
 * Start this application IOS
 */
function startAppIOS() {
  Navigation.startTabBasedApp({
    tabs: [
      {
        label: language.search_tab_label, title: language.search_tab_title,
        screen: 'info.search', icon: iconsMap['ios-search'],
        navigatorStyle: navStyle(),
        navigatorButtons: {
          rightButtons: [{icon: iconsMap['undo'], id: 'reset'}],
        }
      },
      {
        label: language.news_tab_label, title: language.news_tab_title,
        screen: 'info.news', icon: iconsMap['newspaper-o'],
        navigatorStyle: navStyle(),
        /*navigatorButtons: {
          rightButtons: [{title: language.more_title, id: 'more'}]
        }*/
      },
      {
        label: language.wiki_title, title: language.drawer_wiki,
        screen: 'info.wiki', icon: iconsMap['wikipedia-w'],
        navigatorStyle: navStyle()
      },
      {
        label: language.settings_tab_label, title: language.settings_tab_title,
        screen: 'info.settings', icon: iconsMap['ios-settings'],
        navigatorStyle: navStyle()
      }
    ],
    tabsStyle: {
      tabBarSelectedButtonColor: theme[500],
      tabBarBackgroundColor: getTextColour(theme[500]),
      tabBarTranslucent: true,
      initialTabIndex: saved_tab,
    },
    animationType: 'fade'
  });
}

/**
 * Start with app android
 */
function startAppAndroid() {
  Navigation.startSingleScreenApp({
    screen: {
      title: language.search_tab_title,
      screen: 'info.news',
      navigatorStyle: navStyle(),
      navigatorButtons: {
        leftButtons: [{icon: iconsMap['menu'], id: 'drawer'}],
        /*rightButtons: [{title: language.more_title, id: 'more'}],*/
        fab: {
          collapsedId: 'search',
          collapsedIcon: iconsMap['ios-search'],
          collapsedIconColor: getTextColour(theme[500]),
          backgroundColor: theme[500],
        }
      }
    },
    drawer: {
      left: {
        screen: 'app.drawer',
      },
    }
  })
}

/**
 * Haptic feedback for android
 */
export function hapticFeedback() {
  if (!android) {
    let ReactNativeHaptic = require('react-native-haptic').default;
    ReactNativeHaptic.generate('selection');
  }
}

/**
 * Determine if device is iphone x
 */
export function isIphoneX() {
  const dimen = Dimensions.get('window');
  return (
      Platform.OS === 'ios' &&
      !Platform.isPad &&
      !Platform.isTVOS &&
      (dimen.height === 812 || dimen.width === 812)
  );
}