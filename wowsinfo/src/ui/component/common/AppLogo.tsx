import React, { Component } from "react";
import { WoWsComponent } from "../WoWsComponent";
import { View, StyleSheet, Animated, Dimensions, Easing } from "react-native";
import { Colors } from "react-native-paper";
import { Actions } from "react-native-router-flux";

export interface AppLogoProps {
  size: number,
  /**
   * Do the zoom animation
   */
  zoom?: boolean,
  /**
   * White icon
   */
  white?: boolean,
}

class AppLogo extends Component<AppLogoProps> implements WoWsComponent {
  isProFeature: boolean = false;
  size!: Animated.Value;

  constructor(props: AppLogoProps) {
    super(props);

    this.size = new Animated.Value(props.size);
    if (props.zoom) {
      // Display the animation
      const { width, height } = Dimensions.get('window');
      setTimeout(() => {
        Actions.replace('Home');
      }, 900);
      
      Animated.sequence([
        Animated.timing(this.size, {
          toValue: 80,
          duration: 600
        }),
        Animated.timing(this.size, {
          toValue: Math.max(width, height) * 1.5,
          duration: 300
        })
      ]).start();
    }
  }

  render() {
    const placeholder = {
      height: this.size,
      width: this.size,
      // White logo
      backgroundColor: this.props.white ? 'white' : Colors.blue500
    };

    return (
      <Animated.View style={placeholder} />
    )
  }
}

const styles = StyleSheet.create({

});

export { AppLogo };
