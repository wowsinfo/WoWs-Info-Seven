import React, { Component } from 'react';
import { View, ScrollView, StyleSheet } from 'react-native';
import { Text, Portal, Surface, Button, Dialog, TextInput, Title, Caption  } from 'react-native-paper';
import lang from '../../value/lang';

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
              <Title>{lang.rs_tip_download}</Title>
              <Text>{lang.rs_tip_one}</Text>
              <Title>{lang.rs_tip_setup}</Title>
              <Text>{lang.rs_tip_two}</Text>
              <Title>{lang.rs_tip_enjoy}</Title>
              <Text>{lang.rs_tip_three}</Text>
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
