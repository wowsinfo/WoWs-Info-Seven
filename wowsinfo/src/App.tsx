/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Generated with the TypeScript template
 * https://github.com/react-native-community/react-native-template-typescript
 *
 * @format
 */

import React, { Component } from 'react';
import { WoWsComponent, WoWsState } from './ui/component/WoWsComponent';
import DataStorage from './core/util/DataStorage';
import { Router, Stack, Scene } from 'react-native-router-flux';
import { Welcome } from './ui/page/Welcome';
import { Home } from './ui/page';
import { StatusBar } from 'react-native';
import { Surface } from 'react-native-paper';
import { ConsumerForAll, LoadingIndicator } from './ui/component';

interface AppState extends WoWsState {

}

export default class App extends Component<{}, AppState> implements WoWsComponent {
  isProFeature: boolean = false;
  dataStorage = DataStorage.Instance;

  constructor(props: {}) {
    super(props);

    this.state = {
      loading: true,
      error: DataStorage.OK,
    };

    // only get essential data from local storage
    // this.dataStorage.initSome().then(() => {
    //   this.setState({
    //     loading: false,
    //   });
    // })
  }

  /**
   * render the status bar according to theme
   */
  renderStatusBar() {
    return (
      <ConsumerForAll>
        {c => {
          if (c) {
            const theme = c.theme;
            const bar = theme.isLight() ? 'dark-content' : 'light-content' ;
            const background = theme.isDarkTheme() ? 'black' : theme.getPrimary();
            return <StatusBar barStyle={bar} backgroundColor={background} />;
          } else {
            // Just put a status bar if somehow c is not defined (it should never happen though)
            return <StatusBar />
          }
        }}
      </ConsumerForAll>
    )
  }

  render() {
    const { loading, error } = this.state;

    if (loading) {
      return <LoadingIndicator />;
    } else {
      return (
        <Surface style={{ flex: 1 }}>
          {this.renderStatusBar()}
          <Router>
            <Stack key='root' hideNavBar>
              <Scene key='Welcome' component={Welcome} />
              <Scene key='Home' component={Home} />
            </Stack>
          </Router>
        </Surface>
      );
    }
  }
}
