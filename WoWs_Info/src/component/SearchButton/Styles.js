import { StyleSheet, Platform } from 'react-native';

export const styles = StyleSheet.create({
  buttonStyle: {
    backgroundColor: 'transparent',
    margin: 0,
    padding: 0,
  }
})

export const buttonIcon = {
  name: 'search',
  type: 'evil-icons', 
  size: (Platform.OS == 'ios') ? 22 : 30
}