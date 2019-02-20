/**
 * SectionTitle.js
 * 
 * A themed title
 */

import React, { Component } from 'react';
import { StyleSheet } from 'react-native';
import { ThemeBackColour, TintTextColour } from '../../value/colour';
import { Title } from 'react-native-paper';

class SectionTitle extends Component {
  render() {
    const { title, back, center, style } = this.props;
    const { text } = styles;

    return (
      <Title style={[back ? ThemeBackColour() : null, TintTextColour(), text, style, center ? {alignSelf: 'center'} : null]}>
        {title}
      </Title>
    )
  };
}

const styles = StyleSheet.create({
  text: {
    paddingLeft: 16,
    paddingTop: 8,
  }
});

export { SectionTitle };
