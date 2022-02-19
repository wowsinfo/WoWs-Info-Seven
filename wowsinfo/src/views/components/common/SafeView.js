/**
 * SafeView.js
 *
 * Wrap view around SafeAreView and Surface
 */

import React, {Component} from 'react';
import {SafeAreaView, StyleSheet} from 'react-native';
import {Surface} from 'react-native-paper';

class SafeView extends Component {
  render() {
    const {theme, style, children} = this.props;
    return (
      <Surface theme={theme} style={[style, styles.container]}>
        <SafeAreaView style={styles.container}>{children}</SafeAreaView>
      </Surface>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export {SafeView};
