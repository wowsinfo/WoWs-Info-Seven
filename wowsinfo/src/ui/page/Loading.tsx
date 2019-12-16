import React, { Component } from "react";
import { WoWsComponent } from "../component/WoWsComponent";
import { Surface, withTheme, Theme, Colors, ActivityIndicator, Text, Paragraph } from "react-native-paper";
import { ConsumerForAll, AppLogo } from "../component";
import { StyleSheet } from "react-native";

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
    return (
      <ConsumerForAll>
        { c => (
          <Surface style={rootView}>
            <AppLogo size={128} />
        <Text style={{padding: 16}}>{this.state.message}</Text>
            <ActivityIndicator />
          </Surface>
        )}
      </ConsumerForAll>
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
