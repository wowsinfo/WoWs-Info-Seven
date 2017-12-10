import React from 'react';
import { Text } from 'react-native';
import GridView from 'react-native-super-grid';

class WikiScreen extends React.PureComponent {
  render() {
    return (
      <GridView itemDimension={100} items={}
        renderItem={item => (<Text>{item}</Text>)}/>
    )
  }
}

export {WikiScreen};