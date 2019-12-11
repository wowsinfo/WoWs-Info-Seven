/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Generated with the TypeScript template
 * https://github.com/react-native-community/react-native-template-typescript
 *
 * @format
 */

import React, { Component, useContext } from 'react';
import { WoWsComponent, WoWsState } from './ui/component/WoWsComponent';
import DataStorage from './core/util/DataStorage';
import { Router, Stack, Scene } from 'react-native-router-flux';
import { Welcome, Agreement } from './ui/page/Welcome';
import { Home, Settings, ProVersion } from './ui/page';
import { StatusBar, StyleSheet } from 'react-native';
import { Surface, Colors } from 'react-native-paper';
import { ConsumerForAll, ContextForAll } from './ui/component';

interface AppState extends WoWsState {

}

/**
 * The root of WoWs Info
 * - Setup data
 * - Setup router
 */
export default class App extends Component<{}, AppState> implements WoWsComponent {
  isProFeature: boolean = false;
  dataStorage = DataStorage.Instance;
  shouldUpdateTheme: boolean = true;

  constructor(props: {}) {
    super(props);

    this.state = {
      loading: true,
      error: DataStorage.OK,
    };

    // only get essential data from local storage
    this.dataStorage.initSome().then(() => {
      this.setState({
        loading: false,
      });
    })
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

    if (error !== DataStorage.OK) {
      // render nothing for now
      // TODO: update to error component
      return null;
    } else if (loading) {
      return null;
    } else {
      return (
        <Surface style={styles.view}>
          <Router>
            <Stack key='root' hideNavBar>
              { /** Welcome */ }
              <Scene key='Welcome' component={Welcome} />
              <Scene key='Agreement' component={Agreement} />
              <Scene key='Settings' component={Settings} />
              <Scene key='ProVersion' component={ProVersion} />
              
              { /** WoWs Info */ }
              <Scene key='Home' component={Home} />
            </Stack>
          </Router>
        </Surface>
      );
    }
  }
}

const styles = StyleSheet.create({
  view: {
    flex: 1,
  }
});
