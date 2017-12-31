import { StyleSheet, Dimensions } from 'react-native';

export const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
    paddingTop: 8, 
    paddingBottom: 8,   
  },
  titleStyle: {
    textAlign: 'center',
    fontSize: 28,
    fontWeight: '300',
  },
  subViewStyle: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
  },
  imageViewStyle: {
    alignItems: 'center',
  },
  imageStyle: {
    width: 150,
    height: 90,
  },
  nameStyle: {
    textAlign: 'center',
  },
  numberStyle: {
    fontSize: 34,
    textAlign: 'center',
    fontWeight: '200',
    width: 160,
    height: 50,
  },
})