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
import { Router, Stack, Scene, Actions } from 'react-native-router-flux';
import { Agreement } from './ui/page/Welcome';
import { Home, Settings, ProVersion, About, Loading } from './ui/page';
import { View, StatusBar, StyleSheet, BackHandler } from 'react-native';
import { Surface, Colors } from 'react-native-paper';
import { ConsumerForAll } from './ui/component';
import DataManager from './core/data/DataManager';

interface AppState extends WoWsState {

}

/**
 * The root of WoWs Info
 * - Setup data
 * - Setup router
 */
export default class App extends Component<{}, AppState> implements WoWsComponent {
  isProFeature: boolean = false;
  DataManager = DataManager.Instance;
  shouldUpdateTheme: boolean = true;

  constructor(props: {}) {
    super(props);

    this.state = {
      loading: true,
      error: DataManager.OK,
    };

    // only get essential data from local storage
    this.DataManager.initEssential().then(() => {
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
            const background = theme.isDarkTheme() ? Colors.grey900 : theme.getPrimary();
            return <StatusBar backgroundColor={background} />;
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

    if (error !== DataManager.OK) {
      // render nothing for now
      // TODO: update to error component
      return null;
    } else if (loading) {
      return null;
    } else {
      // About page in setup mode
      const aboutPage = () => <About isSetup />;

      return (
        <View style={{flex: 1}}>
          {this.renderStatusBar()}
          <Router sceneStyle={{flex: 1, backgroundColor: 'white'}} backAndroidHandler={this.handleBack}>
            <Stack key='root' hideNavBar>
              <Scene key='Loading' component={Loading} />
              { /** Welcome */}
              <Scene key='About' component={aboutPage} />
              <Scene key='Agreement' component={Agreement} />
              <Scene key='Settings' component={Settings} />
              <Scene key='ProVersion' component={ProVersion} />

              {/** Loading */}

              { /** Home */}
              <Scene key='Home' component={Home} />
            </Stack>
          </Router>
        </View>
      );
    }
  }

  handleBack = () => {
    // console.log(Actions.state.routes.length == 1);
    // if (Actions.state.routes.length == 1) {
    //   BackHandler.exitApp();
    // }
  }
}

const styles = StyleSheet.create({
});
