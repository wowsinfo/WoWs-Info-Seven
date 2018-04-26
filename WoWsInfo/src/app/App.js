import { Navigation } from 'react-native-navigation';
import { Platform } from 'react-native';
import { registerScreens } from '../screen';

import { Blue, Green, Red, RED, BLUE, GREEN } from 'react-native-material-color';
import { getTextColour, statusBarColour, navStyle } from '../constant/colour';

import language from '../constant/language';
import { iconsLoaded, iconsMap } from '../constant/icon';

// Loading icons
iconsLoaded.then(() => {
  registerScreens();
  !android ? startAppIOS() : startAppAndroid();
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
    tabsStyle: {
      tabBarSelectedButtonColor: Blue,
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
      screen: 'info.News', icon: iconsMap['newspaper-o'],
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
  })
}