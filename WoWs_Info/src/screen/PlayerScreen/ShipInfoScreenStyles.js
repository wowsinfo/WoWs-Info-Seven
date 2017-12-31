import { StyleSheet, Platform } from 'react-native';

export const styles = StyleSheet.create({
  noInfoViewStyle: {
    flex: 1,
    justifyContent: 'center',
  },
  noInfoTextStyle: {
    textAlign: 'center',
    fontSize: 24,
    fontWeight: '300',
    margin: 8,
  },
  mainViewStyle: {
    flex: 1,
  },
  ratingStyle: {
    textAlign: 'center',
    fontSize: 24,
    fontWeight: 'bold',
    margin: 4,
  },
  filterViewStyle: { 
    flexDirection: 'row', 
    alignItems: 'center', 
    justifyContent: 'center',
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
  },
  resetStyle: {
    marginLeft: 8,
    height: 40,
    width: 40,
  },
  footerViewStyle: {
    flex: 1,
    flexDirection: 'row',
    marginBottom: 20,
  },
  poweredStyle: {
    flex: 0.9,
  },
  totalShipStyle: {
    flex: 0.1,
    alignItems: 'flex-end',
  }
})