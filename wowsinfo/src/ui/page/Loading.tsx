import React, { Component } from "react";
import { WoWsComponent } from "../component/WoWsComponent";
import { Surface, ActivityIndicator, Text } from "react-native-paper";
import { AppLogo } from "../component";
import { StyleSheet, Animated } from "react-native";

interface LoadingState {
  message: string,
  done: boolean
}

class Loading extends Component<{}, LoadingState> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: {}) {
    super(props);

    this.state = {
      message: 'Checking for updates...',
      done: false
    }
  }
  
  render() {
    const { rootView } = styles;
    const { message } = this.state;

    return (
      <Surface style={rootView}>
        <AppLogo size={128} zoom/>
        <Text style={{padding: 16}}>{message}</Text>
        <ActivityIndicator />
      </Surface>
    );
  }
}

const styles = StyleSheet.create({
  rootView: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
})

export { Loading };
