import { StyleSheet, Dimensions } from 'react-native';

const { width, height } = Dimensions.get('window')
let imageWidth = (width < height) ? width * 0.382 : height * 0.382;
// Larger font for tablet
let DeviceInfo = require('react-native-device-info');
let isTablet = DeviceInfo.isTablet();
export const styles = StyleSheet.create({
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
    fontSize: isTablet ? 36 : 20,
  },
})