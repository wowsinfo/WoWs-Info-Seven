import React, { Component } from 'react';
import { View, Image, ScrollView, StyleSheet, Dimensions } from 'react-native';
import { Surface, Text, Title } from 'react-native-paper';
import { BackButton } from '../component';

class About extends Component {
  constructor(props) {
    super(props);
    
    const { height } = Dimensions.get('window');
    this.state = {
      padding: height / 2 - 128
    }
  }

  render() {
    const { container, logo } = styles;
    const { padding } = this.state;
    return (
      <Surface style={container} onLayout={() => this.updatePadding()}>
        <ScrollView contentContainerStyle={{paddingTop: padding, alignItems: 'center'}}>
          <Image style={logo} source={require('../img/Logo.png')}/>
          <Title>WoWs Info</Title>
          <Text>Sample Text</Text>
        </ScrollView>
        <BackButton />
      </Surface>
    )
  };

  /**
   * Update scrollview padding to make sure logo is about centered
   */
  updatePadding() {
    const { height } = Dimensions.get('window');
    this.setState({padding: height / 2 - 128});
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  logo: {
    height: 128, width: 128
  }
});

export { About };
