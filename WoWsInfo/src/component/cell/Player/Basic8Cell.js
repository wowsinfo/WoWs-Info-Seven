import React, { Component } from 'react';
import { View, StyleSheet } from 'react-native';
import { Info3Cell } from './Info3Cell';
import { Image1Cell } from './Image1Cell';
import { Text1Cell } from './Text1Cell';
import language from '../../../constant/language';

class Basic8Cell extends Component {
  constructor(props) {
    super(props);
    // TODO: in the future, all calculation will be done here
  }

  render() {
    const { mainViewStyle, subViewStyle } = styles;
    const { info } = this.props;
    return (
      <View style={mainViewStyle}>
        <Info3Cell info={info}/>              
        <View style={subViewStyle}>
          <Image1Cell image={require('../../../img/EXP.png')} text={info.exp}/>
          <Image1Cell image={require('../../../img/KillDeathRatio.png')} text={info.killdeath}/>                    
          <Image1Cell image={require('../../../img/HitRatio.png')} text={info.hitratio + '%'}/>
        </View>
        <View style={subViewStyle}>
          <Text1Cell name={language.player_survival_rate} text={info.survival + '%'}/>
          <Text1Cell name={language.player_average_frag} text={info.frag}/>
        </View>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
    margin: 8,
  },
  subViewStyle: {
    flex: 1,
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-around',
    padding: 4,
  }
})

export {Basic8Cell};