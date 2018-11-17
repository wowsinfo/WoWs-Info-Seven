import React, { Component } from 'react';
import { View, ScrollView, StyleSheet } from 'react-native';
import { Text, Portal, Surface, Button, Dialog, TextInput, Title, Caption  } from 'react-native-paper';

class RS extends Component {
  constructor(props) {
    super(props);

    this.state = {
      tip: false
    };
  }

  render() {
    const { container } = styles;
    const { tip } = this.state;
    return (
      <View style={container}>
        <Text>Imagine that this is a text input</Text>
        <Button onPress={() => this.setState({tip: true})}>How to use?</Button>
        { this.renderDialog(tip) }
      </View>
    )
  };

  renderDialog(tip) {
    return (
      <Portal>
        <Dialog visible={tip} dismissable={true} theme={{roundness: 8}}
          style={{maxHeight: '61.8%'}} onDismiss={() => this.setState({tip: false})}>
          <Dialog.Content>
            <ScrollView showsVerticalScrollIndicator={false}>
              <Title>Download</Title>
              <Text>
                Please visit this Github repository and download the latest release.
                This program does not use lots of RAM and storage.
                Currently, it is in its beta stage and has no GUI.
              </Text>
              <Title>Setup</Title>
              <Text>
                Copy and paste the path of your game folder into this program and 
                you have to run it with admin or it will not work.
                It won't do anything harmful to your computer.
              </Text>
              <Title>Enjoy</Title>
              <Text>
                Enter the IP address you see on the screen and WoWs Info will start
                giving your real-time statistics for both teams.
              </Text>
              <Caption>{'\n\n- HenryQuan'}</Caption>
            </ScrollView>
          </Dialog.Content>
        </Dialog>
      </Portal>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export { RS };
