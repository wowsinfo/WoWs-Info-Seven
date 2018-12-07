import React, { Component } from 'react';
import { Image, ScrollView, StyleSheet } from 'react-native';
import { Surface, Text, Title } from 'react-native-paper';
import { FooterButton } from '../component';
import { APP } from '../value/data';

class About extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { container, scroll, logo } = styles;
    return (
      <Surface style={container}>
        <ScrollView contentContainerStyle={scroll}>
          <Image style={logo} source={require('../img/Logo.png')}/>
          <Title>WoWs Info</Title>
          <Text>{APP.Version}</Text>
        </ScrollView>
        <FooterButton />
      </Surface>
    )
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  scroll: {
    flex: 1,
    padding: 16,
    alignItems: 'center',
    justifyContent: 'center'
  },
  logo: {
    height: 128, width: 128
  }
});

export { About };
