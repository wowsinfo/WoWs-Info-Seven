import { StyleSheet, Dimensions } from 'react-native';

const { width, height } = Dimensions.get('window');
// If user enters this app with landscape mode, it might look off since the image is quite big
let imageWidth = (width < height) ? width * 0.3 : height * 0.3;

// Larger font for tablet
let DeviceInfo = require('react-native-device-info');
let isTablet = DeviceInfo.isTablet();
export const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
    flexDirection: 'row',
    margin: 0,
    padding: 0,
  },
  imageViewStyle: {
    width: imageWidth,
    margin: 0,
    padding: 4,
    justifyContent: 'center',
  },
  textViewStyle: {
    flex: 1,
    margin: 0,
    padding: 8,
    justifyContent: 'space-around',
  },
  imageStyle: {
    width: imageWidth,
    height: imageWidth / 1.52,
    margin: 0,
  },
  titleStyle: {
    fontSize: isTablet ? 36 : 16,
  },
  timeStyle: {
    fontSize: isTablet ? 24 : 12,
    textAlign: 'right',
  }
})
