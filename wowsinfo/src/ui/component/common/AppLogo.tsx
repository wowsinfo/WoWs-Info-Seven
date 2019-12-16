import React, { Component } from "react";
import { WoWsComponent } from "../WoWsComponent";
import { View, StyleSheet } from "react-native";
import { Colors } from "react-native-paper";

export interface AppLogoProps {
  size: number,
  white?: boolean,
}

class AppLogo extends Component<AppLogoProps> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: AppLogoProps) {
    super(props);
  }

  render() {
    const placeholder = {
      height: this.props.size,
      width: this.props.size,
      backgroundColor: Colors.blue500
    };

    // White logo
    if (this.props.white) {
      return <View style={[placeholder, { backgroundColor: 'white' }]} />
    } else {
      return <View style={placeholder} />;
    }
  }
}

const styles = StyleSheet.create({

});

export { AppLogo };
