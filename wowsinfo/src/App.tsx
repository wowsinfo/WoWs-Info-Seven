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

export interface AppState extends WoWsState {
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

    // Setup the entire app
    this.dataStorage.initSome().then(() => {
      this.setState({
        loading: false,
      });
    })
  }

  render() {
    return (
      <Router>
        <Stack key='root'>
          <Scene key='Welcome' component={Welcome} />
          <Scene key='Home' component={Home} />
        </Stack>
      </Router>
    );
  }
}
