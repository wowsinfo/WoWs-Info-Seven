import React, { Component } from 'react';
import { WoWsComponent, WoWsState } from '../../component/WoWsComponent';
import { Surface, Appbar, BottomNavigation, Text } from 'react-native-paper';
import { StyleSheet } from 'react-native';
import { Wiki, Website, Search, Account, RS } from './Tabs';
import { langs } from '../../../core/value/Language';
import Utils from '../../../core/util/Utils';

interface HomeState extends WoWsState {
  index: number,
  routes: Route[]
}

interface Route {
  key: string,
  title: string,
  icon: string
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
        { key: 'wiki', title: langs.home_tab_wiki!, icon: 'book' },
        { key: 'website', title: langs.home_tab_website!, icon: 'web' },
        { key: 'search', title: langs.home_tab_search!, icon: 'magnify' },
        { key: 'rs', title: langs.home_tab_rs!, icon: 'poll' },
        { key: 'main', title: langs.home_tab_main!, icon: 'account' },
      ],
      loading: true,
      error: ''
    };
  }

  renderScene = BottomNavigation.SceneMap({
    wiki: () => <Wiki />,
    website: () => <Website />,
    search: () => <Search />,
    rs: () => <RS />,
    main: () => <Account />,
  });

  handleIndexChange = (index: number) => this.setState({ index });

  render() {
    const { rootView } = styles;
    // TODO: render a bottom navigation
    return (
      <Surface style={rootView}>
        <BottomNavigation navigationState={this.state} shifting={!Utils.isIOS()}
          onIndexChange={this.handleIndexChange} renderScene={this.renderScene} />
      </Surface>
    )
  }
}

const styles = StyleSheet.create({
  rootView: {
    flex: 1
  }
});

export { Home };
