import React, { Component } from 'react';
import { WoWsComponent, WoWsState } from '../../component/WoWsComponent';
import { Surface, Appbar, BottomNavigation, Text } from 'react-native-paper';
import { StyleSheet } from 'react-native';
import { Wiki, Website, Search, User, RS } from './Tabs';
import { langs } from '../../../core/value/Language';
import Utils from '../../../core/Utils';
import { ConsumerForAll } from '../../component';

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

  handleIndexChange = (index: number) => this.setState({ index });

  render() {
    return (
      <ConsumerForAll>
        { c => {
          const theme = c!.theme;
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
