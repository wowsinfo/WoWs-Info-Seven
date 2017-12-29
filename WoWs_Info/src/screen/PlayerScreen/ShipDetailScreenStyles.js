import { StyleSheet, Dimensions } from 'react-native';

const { width } = Dimensions.get('window');
let imageWidth = width * 0.382; 
export const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
  },
  scrollViewStyle: {
  },
  imageStyle: {
    width: imageWidth,
    height: imageWidth / 1.697,
    alignSelf: 'center',
  },
  shipNameStyle: {
    textAlign: 'center',
    fontSize: 20,
    fontWeight: '200',
    margin: 4,
  },
  ratingStyle: {
    textAlign: 'center',
    fontSize: 24,
    fontWeight: 'bold',
    margin: 4,
  },
})