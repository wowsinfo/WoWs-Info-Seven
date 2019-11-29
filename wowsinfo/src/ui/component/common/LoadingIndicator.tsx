
 import React, { Component } from "react";
 import { WoWsComponent } from "../WoWsComponent";
 import { Surface, ActivityIndicator } from "react-native-paper";
 import { StyleSheet } from "react-native";

 /**
  * It is a big circular indictor with the current theme
  */
 class LoadingIndicator extends Component implements WoWsComponent {
  isProFeature: boolean = false;

  render() {
    return (
      <Surface style={styles.view}>
        <ActivityIndicator animating={true} size='large' />
      </Surface>
    )
  }
}

const styles = StyleSheet.create({
  view: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  }
});

export { LoadingIndicator };
