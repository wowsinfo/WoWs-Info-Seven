import React, { PureComponent } from 'react';
import { View, Image, Text, StyleSheet, Alert } from 'react-native';
import { WoWsTouchable } from '../../component';

class BasicCell extends PureComponent {
  render() {
    const { icon, player, data } = this.props;
    // console.log(data);
    return (
      <WoWsTouchable onPress={() => player ? Alert.alert(data.name, data.text) : this.showDetail()}>
        <View style={viewStyle}>
          <Image source={{uri: icon}} style={imageStyle} resizeMode='contain'/>
          { this.renderCount() }
        </View>
      </WoWsTouchable>
    )
  }

  renderCount() {
    const { data, isCollection } = this.props;
    if (!isCollection && data.count != null) return <Text style={textStyle}>{data.count}</Text>
    else return null;
  }

  showDetail() {
    const { data, isCollection, detail, collection } = this.props;
    if (!isCollection) detail(data);
    else collection(data);
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  imageStyle: {
    height: 80, 
    width: 80,
  },
  textStyle: {
    textAlign: 'center',
    fontSize: 16,
    fontWeight: '300',
  }
})
const { viewStyle, imageStyle, textStyle } = styles;

export { BasicCell };