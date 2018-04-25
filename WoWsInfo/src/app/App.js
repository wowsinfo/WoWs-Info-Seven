import { Navigation } from 'react-native-navigation';
import { registerScreens } from '../screen';

import { Blue, Green, Red } from 'react-native-material-color';
import { getTextColour, statusBarColour } from '../constant/colour';
import { DataStorage } from '../core/';
import language from '../constant/language';

registerScreens();
DataStorage.DataValidation().then(() => {
  Navigation.startTabBasedApp({
    tabs: [
      {
        label: language.news_tab_label, title: language.news_tab_title,
        screen: 'info.News',
        navigatorStyle: {
          navBarTextColor: getTextColour(Red),
          navBarBackgroundColor: Red,
          statusBarTextColorScheme: statusBarColour(Red)
        }
      },
      {
        label: language.search_tab_label, title: language.search_tab_title,
        screen: 'info.Search',
        navigatorStyle: {
          navBarTextColor: getTextColour(Blue),
          navBarBackgroundColor: Blue,
          statusBarTextColorScheme: statusBarColour(Blue)
        }
      },
      {
        label: language.settings_tab_label, title: language.settings_tab_title,
        screen: 'info.Settings',
        navigatorStyle: {
          navBarTextColor: getTextColour(Green),
          navBarBackgroundColor: Green,
          statusBarTextColorScheme: statusBarColour(Green)
        }
      }
    ],
    tabsStyle: {
      tabBarSelectedButtonColor: Blue,
      forceTitlesDisplay: false,
      tabBarTranslucent: true,
      initialTabIndex: 1
    },
    animationType: 'fade'
  });
})