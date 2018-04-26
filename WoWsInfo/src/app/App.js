import { Navigation } from 'react-native-navigation';
import { Platform } from 'react-native';
import { registerScreens } from '../screen';

import { Blue, Green, Red, RED, BLUE, GREEN } from 'react-native-material-color';
import { getTextColour, statusBarColour, navStyle } from '../constant/colour';

import language from '../constant/language';
import { iconsLoaded, iconsMap } from '../constant/icon';
import { DataStorage } from '../core';

// Loading icons
iconsLoaded.then(() => {
  registerScreens();
  loadingData();
  DataStorage.DataValidation().then(() => {
    !android ? startAppIOS() : startAppAndroid();
  })
});

/**
 * Loading data screen
 */
function loadingData() {
  Navigation.startSingleScreenApp({
    screen: {
      screen: 'info.wowsinfo',
      navigatorStyle: {
        navBarHidden: true,
        statusBarTextColorScheme: 'light'
      },
    },
    animationType: 'none'
  });
}

/**
 * Start this application IOS
 */
function startAppIOS() {
  Navigation.startTabBasedApp({
    tabs: [
      {
        label: language.news_tab_label, title: language.news_tab_title,
        screen: 'info.news', icon: iconsMap['newspaper-o'],
        navigatorStyle: navStyle()
      },
      {
        label: language.search_tab_label, title: language.search_tab_title,
        screen: 'info.search', icon: iconsMap['ios-search'],
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
      screen: 'info.news', icon: iconsMap['newspaper-o'],
      navigatorStyle: navStyle(),
      appStyle: {
        forceTitlesDisplay: false
      },
      navigatorButtons: {
        leftButtons: [
          {
            icon: iconsMap['menu'],
            id: 'drawer'
          }
        ],
        fab: {
          collapsedId: 'search',
          collapsedIcon: iconsMap['ios-search'],
          collapsedIconColor: getTextColour(Blue),
          backgroundColor: BLUE[500]
        }
      }
    },
    drawer: {
      left: {
        screen: 'info.drawer',
      },
    }
  })
}