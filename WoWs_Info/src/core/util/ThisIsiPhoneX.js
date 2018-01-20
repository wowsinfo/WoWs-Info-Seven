import { Dimensions, Platform } from 'react-native';

export const ThisIsiPhoneX = () => {
  const { height, width } = Dimensions.get('window');
  return Platform.OS === 'ios' && (height === 812 || width === 812)
}