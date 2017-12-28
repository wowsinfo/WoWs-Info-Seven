import { StyleSheet, Dimensions } from 'react-native';

const { width, height } = Dimensions.get('window');
const imageWidth = ( height > width ) ? width * 0.382 : height * 0.382;
let device = require('react-native-device-info');
export const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
    paddingTop: 8,    
  },
  titleStyle: {
    textAlign: 'center',
    fontSize: 24,
    fontWeight: '300',
  },
  subViewStyle: {
    flexDirection: 'row',
    padding: 4,
  },
  imageViewStyle: {
    width: imageWidth,
  },
  imageStyle: {
    width: imageWidth,
    height: imageWidth / 1.679,
  },
  nameStyle: {
    textAlign: 'center',
  },
  numberStyle: {
    fontSize: device.isTablet() ? 96 : 48,
    textAlign: 'center',
    textAlignVertical: 'center',
    fontWeight: '200',
    flex: 1,
    padding: 16,
  },
})