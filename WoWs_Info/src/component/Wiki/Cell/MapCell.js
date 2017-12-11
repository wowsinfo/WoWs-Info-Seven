import React from 'react';
import { Card } from 'react-native-elements';
import { Text } from 'react-native';
import { styles } from './WikiCellStyles';

class MapCell extends React.PureComponent {
  render() {
    return (
      <Card title={this.props.name} containerStyle={cardStyle}>
        <Text style={textStyle}>{this.props.info}</Text>
      </Card>
    )
  }
}

const { textStyle, cardStyle } = styles;

export {MapCell};