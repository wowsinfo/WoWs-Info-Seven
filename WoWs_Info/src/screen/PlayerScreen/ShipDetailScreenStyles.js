import { StyleSheet, Dimensions } from 'react-native';

const { width, height } = Dimensions.get('window');
let imageHeight = height > width ? width * 0.382 : height * 0.382; 
export const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
  },
  imageStyle: {
    width: imageHeight * 1.697,
    height: imageHeight,
    alignSelf: 'center',
  },
  shipNameStyle: {
    textAlign: 'center',
    fontSize: 20,
    fontWeight: '300',
    margin: 4,
  },
  ratingStyle: {
    textAlign: 'center',
    fontSize: 24,
    fontWeight: 'bold',
    margin: 4,
  },
})