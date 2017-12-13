import { StyleSheet, Dimensions } from 'react-native';

let imageWidth = Dimensions.get('window').width * 0.3;
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
    fontSize: 16,
  },
  timeStyle: {
    fontSize: 12,
    textAlign: 'right',
  }
})
