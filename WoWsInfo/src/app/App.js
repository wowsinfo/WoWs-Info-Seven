import { Navigation } from 'react-native-navigation';
import { registerScreens } from '../screen';

import { Blue, Green, Red } from 'react-native-material-color';
import { getTextColour, statusBarColour } from '../constant/colour';
import { DataStorage } from '../core/';
import { language } from '../constant/language';

registerScreens();
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