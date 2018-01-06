import { StyleSheet, Dimensions } from 'react-native';

const { width, height } = Dimensions.get('window')
let imageWidth = (width < height) ? width * 0.382 : height * 0.382;

export const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
  },
  viewStyle: {
    paddingTop: 8,
    flex: 1,
    alignItems: 'center',
  },
  imageStyle: {
    width: imageWidth,
    height: imageWidth,
    borderRadius: imageWidth / 8,
  },
  textStyle: {
    textAlign: 'center',
    margin: 8,
    fontSize: 26,
  },
})