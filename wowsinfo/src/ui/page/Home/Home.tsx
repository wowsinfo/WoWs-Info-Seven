import React, { Component } from 'react';
import { Surface, Appbar, BottomNavigation, Text } from 'react-native-paper';
import { StyleSheet, StatusBar } from 'react-native';
import { Wiki, Website, Search, User, RS } from './Tabs';
import { WoWsState, WoWsComponent } from 'src/ui/component/WoWsComponent';
import { langs } from 'src/core/value/Language';
import { ConsumerForAll } from 'src/ui/component';
import Utils from 'src/core/Utils';

interface HomeState extends WoWsState {
  index: number,
  routes: Route[]
}

interface Route {
  key: string,
  title: string,
  icon: string,
}

/**
 * The home page of this app
 * - It displays a tab navigation for mobiles
 * - It displays a drawer for tablets or devices with a larger display
 */
class Home extends Component<{}, HomeState> implements WoWsComponent {
  isProFeature: boolean = false;
  lightTheme: boolean = false;
  
  constructor(props: {}) {
    super(props);

    this.state = {
      index: 0,
      routes: [
        { key: 'user', title: langs.home_tab_home!, icon: 'home' },
        { key: 'website', title: langs.home_tab_website!, icon: 'web' },
        { key: 'wiki', title: langs.home_tab_wiki!, icon: 'book'  },
        { key: 'rs', title: langs.home_tab_rs!, icon: 'poll' },
        { key: 'search', title: langs.home_tab_search!, icon: 'magnify' },
      ],
      loading: true,
      error: ''
    };
  }

  renderScene = BottomNavigation.SceneMap({
    user: () => <User />,
    website: () => <Website />,
    wiki: () => <Wiki />,
    rs: () => <RS />,
    search: () => <Search />,
  });

  /**
   * Make sure when it is home page and ios light mode, 
   * set the statur bar to dark/black
   */
  handleIndexChange = (index: number) => {
    if (Utils.isIOS() && this.lightTheme) {
      // Update status bar style only for IOS
      StatusBar.setBarStyle(index === 0 ? 'dark-content' : 'light-content');
    }

    this.setState({ index });
  }

  render() {
    return (
      <ConsumerForAll>
        { c => {
          const theme = c!.theme;
          this.lightTheme = theme.isLightTheme();
          let extraProps = {};
          // Use light bottom navigation bar so that it fits in
          if (theme.isLightTheme()) {
            extraProps = {barStyle: {backgroundColor: 'white'}, activeColor: theme.getPrimary()};
          }

          return (
            <BottomNavigation {...extraProps} sceneAnimationEnabled={false}
              navigationState={this.state} shifting={!Utils.isIOS()} 
              onIndexChange={this.handleIndexChange} renderScene={this.renderScene} />
          )
        }}
      </ConsumerForAll>
    )
  }
}

const styles = StyleSheet.create({

});

export { Home };
