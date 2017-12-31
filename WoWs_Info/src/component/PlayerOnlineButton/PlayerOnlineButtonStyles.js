import { StyleSheet, Platform } from 'react-native';

export const styles = StyleSheet.create({
  buttonStyle: {
    margin: 16,
    height: 40,
    width: 40,
  }
})

export const sizeStyle = Platform.OS == 'ios' ? 22 : 30;