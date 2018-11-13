import React, { Component } from 'react';
import { View, Text, ActivityIndicator, StyleSheet } from 'react-native';
import { Modal, Portal } from 'react-native-paper';

class LoadingModal extends Component {
  render() {
    const { container, text } = styles;
    return (
      <Portal>
        <Modal visible={false} dismissable={false} onDismiss={this._hideModal}>
          <View style={container}>
            <ActivityIndicator color='white' size='large'/>
            <Text style={text}>Loading...</Text>
          </View>
        </Modal>
      </Portal>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    alignSelf: 'center', 
    justifyContent: 'center',
    borderRadius: 8
  },
  text: {
    margin: 16,
    color: 'white',
  }
})

export { LoadingModal };