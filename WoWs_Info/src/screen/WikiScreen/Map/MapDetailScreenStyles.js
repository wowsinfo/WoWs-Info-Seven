import { StyleSheet, Dimensions } from 'react-native';

const {width, height} = Dimensions.get('window');
const imageWidth = (width < height) ? width - 16 : height - 16;
export const styles = StyleSheet.create({
  scrollViewStyle: {
    padding: 8,
    alignItems: 'center',
  },
  imageStyle: {
    width: imageWidth,
    height: imageWidth,
  },
  textStyle: {
    marginTop: 8,
    fontSize: 16,
    textAlign: 'center',
  }
})