import { StyleSheet, Platform } from 'react-native';

export const styles = StyleSheet.create({
  buttonStyle: {
    backgroundColor: 'transparent'
  }
})

export const buttonIcon = {
  name: 'search',
  type: 'evil-icons', 
  size: (Platform.OS == 'ios') ? 22 : 30
}