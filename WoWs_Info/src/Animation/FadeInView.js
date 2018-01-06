import React, { Component } from 'react';
import { Animated, ScrollView, Platform } from 'react-native';

class FadeInView extends Component {
  state = {
    // It is hidden by default
    opacityAnim: new Animated.Value(0),
  }

  componentDidMount() {
    // Lets animate
    Animated.timing(
      this.state.opacityAnim,
      {
        toValue: 1,
        duration: 300,
      }
    ).start();
  }
  
  render() {
    const { opacityAnim } = this.state;
    const { style, children } = this.props;
    if (Platform.OS == 'windows') return <ScrollView>{children}</ScrollView>;
    return (
      <Animated.View style={{...style, opacity: opacityAnim}}>
        {children}
      </Animated.View>
    )
  }
}

export {FadeInView};