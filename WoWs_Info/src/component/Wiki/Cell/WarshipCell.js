import React from 'react';
import { View, Text, Image } from 'react-native';
import { styles } from './WarshipCellStyles';

class WarshipCell extends React.PureComponent {
  constructor(props) {
    super();
    this.loadData(props.data);
    this.state = {
      image: this.image,
      tierName: this.tierName,
    }
  }

  // Update saved data
  componentDidUpdate() {
    this.loadData(this.props.data);
    this.setState({
      image: this.image,
      tierName: this.tierName,
    })
  }

  loadData(data) {
    this.image = data.icon;
    let tierList = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];

    // For Chinese user, replace Japanese ships' name
    var name = tierList[data.tier - 1] + ' ';
    this.tierName = name + data.name;
  }

  render() {
    return (
      <View style={viewStyle}>
        <Image source={{uri: this.state.image, cache: 'default'}} style={imageStyle} resizeMode='contain'/>
        <Text style={textStyle}>{this.state.tierName}</Text>
      </View>
    )
  }
}

const { viewStyle, imageStyle, textStyle } = styles;

export {WarshipCell};