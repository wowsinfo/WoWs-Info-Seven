import React from 'react';
import { View } from 'react-native';
import { Info3Cell } from './Info3Cell';
import { Image1Cell } from './Image1Cell';
import { Text1Cell } from './Text1Cell';
import { styles } from './Basic8CellStyles';
import strings from '../../localization';

class Basic8Cell extends React.PureComponent {
  render() {
    const { mainViewStyle, subViewStyle } = styles;
    const { info } = this.props;
    return (
      <View style={mainViewStyle}>
        <Info3Cell info={info}/>
        <View style={subViewStyle}>
          <Image1Cell image={require('../../img/EXP.png')} text={info.exp}/>
          <Image1Cell image={require('../../img/HitRatio.png')} text={info.hitratio + '%'}/>
        </View>
        <View style={subViewStyle}>
          <Text1Cell name={strings.survival_rate} text={info.survival + '%'}/>
          <Image1Cell image={require('../../img/KillDeathRatio.png')} text={info.killdeath}/>          
          <Text1Cell name={strings.average_frag} text={info.frag}/>
        </View>
      </View>
    )
  }
}

export {Basic8Cell};