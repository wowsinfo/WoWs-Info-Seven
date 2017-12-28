import { StyleSheet, Platform } from 'react-native';

export const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
  },
  ratingStyle: {
    textAlign: 'center',
    fontSize: 32,
    fontWeight: 'bold',
    margin: 4,
  },
  filterViewStyle: { 
    flexDirection: 'row', 
    alignItems: 'center', 
    justifyContent: 'center'
  },
  filterButtonStyle: {
    fontSize: 16,
    textAlign: 'center',
    color: 'white',
    margin: 8,
  },
  dropdownStyle: {
    height: 400,
  },
  dropdownTextStyle: {
    fontSize: 16,
    textAlign: 'center',
  },
  inputStyle: {
    width: '40%', 
    borderColor: 'white', 
    color: 'white',
    fontSize: 16,
    textAlign: 'center',
  }
})