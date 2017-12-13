import React from 'react';
import { View, Image, Text } from 'react-native';

class NewsCell extends React.PureComponent {
  render() {
    return (
      <View>
        <View>
          <Image />
        </View>
        <View>
          <Text></Text>
          <Text></Text>
        </View>
      </View>
    );
  }
}

export {NewsCell};