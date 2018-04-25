import { Navigation } from 'react-native-navigation';
import { registerScreens } from '../screen';

import { Blue, Green, Red, RED, BLUE, GREEN } from 'react-native-material-color';
import { getTextColour, statusBarColour } from '../constant/colour';

import { Platform } from 'react-native';
import language from '../constant/language';
import { iconsLoaded, iconsMap } from '../constant/icon';

// Loading icons
iconsLoaded.then(() => {
  registerScreens();
  Platform.OS == 'ios' ? startAppIOS() : startAppAndroid();
});

/**
 * Start this application IOS
 */
function startAppIOS() {
  Navigation.startTabBasedApp({
    tabs: [
      {
        label: language.news_tab_label, title: language.news_tab_title,
        screen: 'info.News', icon: iconsMap['newspaper-o'],
        navigatorStyle: {
          navBarTextColor: getTextColour(Red),
          navBarBackgroundColor: Red,
          statusBarTextColorScheme: statusBarColour(Red),
          navBarButtonColor: getTextColour(Red),
          statusBarColor: RED[700]
        },
        navigatorButtons: {
          leftButtons: [
            {
              icon: iconsMap['menu'],
              id: 'drawer'
            }
          ]
        }
      },
      {
        label: language.search_tab_label, title: language.search_tab_title,
        screen: 'info.Search', icon: iconsMap['ios-search'],
        navigatorStyle: {
          navBarTextColor: getTextColour(Blue),
          navBarBackgroundColor: Blue,
          statusBarTextColorScheme: statusBarColour(Blue),
          navBarButtonColor: getTextColour(Blue),
          statusBarColor: BLUE[700]
        },
        navigatorButtons: {
          leftButtons: [
            {
              icon: iconsMap['menu'],
              id: 'drawer'
            }
          ]
        }
      },
      {
        label: language.settings_tab_label, title: language.settings_tab_title,
        screen: 'info.Settings', icon: iconsMap['ios-settings'],
        navigatorStyle: {
          navBarTextColor: getTextColour(Green),
          navBarBackgroundColor: Green,
          statusBarTextColorScheme: statusBarColour(Green),
          statusBarColor: GREEN[700]
        }
      }
    ],
    drawer: {
      right: {
        screen: 'info.Drawer'
      },
      style: {
        drawerShadow: true,
      },
    },
    tabsStyle: {
      tabBarSelectedButtonColor: Blue,
      tabBarTranslucent: true,
    },
    appStyle: {
      tabBarSelectedButtonColor: Blue,
      forceTitlesDisplay: false,
    },
    animationType: 'fade'
  });
}

/**
 * Start with app android
 */
function startAppAndroid() {
  Navigation.startSingleScreenApp({
    
  })
}