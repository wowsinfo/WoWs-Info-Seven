import { StyleSheet, Platform } from 'react-native';

export const styles = StyleSheet.create({
  buttonStyle: {
    backgroundColor: 'transparent'
  }
})

export const buttonIcon = {
  name: 'stop-circle',
  type: 'feather', 
  size: (Platform.OS == 'ios') ? 22 : 30
}