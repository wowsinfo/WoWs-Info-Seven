import React, {Component} from 'react';
import {View, Text, StyleSheet} from 'react-native';
import {Modal, Portal} from 'react-native-paper';
import {LoadingIndicator} from './LoadingIndicator';

class LoadingModal extends Component {
  render() {
    const {container, text} = styles;
    return (
      <Portal>
        <Modal visible={true} dismissable={false} onDismiss={this._hideModal}>
          <View style={container}>
            <LoadingIndicator />
            <Text style={text}>Loading...</Text>
          </View>
        </Modal>
      </Portal>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    alignSelf: 'center',
    justifyContent: 'center',
    borderRadius: 8,
  },
  text: {
    margin: 16,
    color: 'white',
  },
});

export {LoadingModal};
