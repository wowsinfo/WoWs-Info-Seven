import React, { Component } from "react";
import { WoWsComponent } from "../WoWsComponent";
import { View, StyleSheet } from "react-native";
import { Colors } from "react-native-paper";

class AppLogo extends Component implements WoWsComponent {
  isProFeature: boolean = false;
  
  render() {
    return <View style={styles.placeholder}/>;
  }
}

const styles = StyleSheet.create({
  placeholder: {
    height: 128,
    width: 128,
    backgroundColor: Colors.blue500
  }
});

export { AppLogo };
