import React from 'react';
import { View } from 'react-native';
import { Image1Cell } from './Image1Cell';
import { styles } from './Info3CellStyles';

class Info3Cell extends React.PureComponent {
  render() {
    const { info } = this.props;
    const { viewStyle } = styles;
    return (
      <View style={viewStyle}>
        <Image1Cell image={require('../../img/Battle.png')} text={info.battle}/>
        <Image1Cell image={require('../../img/WinRate.png')} text={info.winrate + '%'} highlight={{height: 56, width: 56}}/>
        <Image1Cell image={require('../../img/Damage.png')} text={info.damage}/>
      </View>
    )
  }
}

export {Info3Cell};