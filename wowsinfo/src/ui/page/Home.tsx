import React, { Component } from 'react';
import { WoWsComponent, WoWsState } from '../component/WoWsComponent';
import { Surface, Appbar } from 'react-native-paper';
import { StyleSheet } from 'react-native';

interface HomeState extends WoWsState {

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
  }

  render() {
    const { rootView } = styles;
    return (
      <Surface style={rootView}>
        <Appbar.Header>

        </Appbar.Header>
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
