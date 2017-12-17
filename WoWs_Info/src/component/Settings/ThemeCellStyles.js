import { StyleSheet, Dimensions } from 'react-native';

const viewHeight = Dimensions.get('window').height * 0.15;
export const styles = StyleSheet.create({
  viewStyle: {
    height: viewHeight,
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  textStyle: {
    fontSize: 16,
    color: 'white',
  }
})