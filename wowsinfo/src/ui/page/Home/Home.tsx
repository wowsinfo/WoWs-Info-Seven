import React, { Component } from 'react';
import { WoWsComponent, WoWsState } from '../../component/WoWsComponent';
import { Surface, Appbar, BottomNavigation, Text } from 'react-native-paper';
import { StyleSheet } from 'react-native';

interface HomeState extends WoWsState {
  index: number,
  routes: Route[]
}

interface Route {
  key: string,
  title: string,
  icon: string
}

const MusicRoute = () => <Text>Music</Text>;

const AlbumsRoute = () => <Text>Albums</Text>;

const RecentsRoute = () => <Text>Recents</Text>;

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
        { key: 'music', title: 'Music', icon: 'queue-music' },
        { key: 'albums', title: 'Albums', icon: 'album' },
        { key: 'recents', title: 'Recents', icon: 'history' },
      ],
      loading: true,
      error: ''
    };
  }

  _renderScene = BottomNavigation.SceneMap({
    music: MusicRoute,
    albums: AlbumsRoute,
    recents: RecentsRoute,
  });

  _handleIndexChange = (index: number) => this.setState({ index });


  render() {
    const { rootView } = styles;
    // TODO: render a bottom navigation
    return (
      <Surface style={rootView}>
        <BottomNavigation navigationState={this.state} shifting
          onIndexChange={this._handleIndexChange} renderScene={this._renderScene} />
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
