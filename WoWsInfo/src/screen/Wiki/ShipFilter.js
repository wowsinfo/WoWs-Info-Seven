import React, { Component } from 'react';
import { View, Picker, StyleSheet, ScrollView, Button, SafeAreaView } from 'react-native';
import language from '../../constant/language';

const tierList = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X'];
export default class ShipFilter extends Component {
  state = this.props.curr;

  render() {
    const { scrollStyle, viewStyle } = styles;
    const { tier, nation, type } = this.state;
    const { encyclopedia, ship_type } = data;

    var ship_nation = [];
    for (key in encyclopedia.ship_nations) ship_nation.push({text: encyclopedia.ship_nations[key], key: key});

    var types = []; 
    for (key in ship_type) types.push({text: ship_type[key], key: key});

    return (
      <View style={{flex: 1, justifyContent: 'space-around'}}>
        <View style={viewStyle}>        
          <Picker selectedValue={nation} mode='dropdown' style={{flex: 0.5}}
            onValueChange={(value, index) => this.setState({nation: value})}>
            <Picker.Item label={language.filter_none} value=''/>
            { this.renderOther(ship_nation) }
          </Picker>
          <Picker selectedValue={tier} mode='dropdown' style={{width: 100}}
            onValueChange={(value, index) => this.setState({tier: value})}>
            <Picker.Item label='0' value=''/>
            { this.renderTier() }
          </Picker>
          <Picker selectedValue={type} mode='dropdown' style={{flex: 0.5}}
            onValueChange={(value, index) => this.setState({type: value})}>
            <Picker.Item label={language.filter_none} value=''/>
            { this.renderOther(types) }
          </Picker>
        </View>
          <Button title={language.filter_done} onPress={() => {
            this.props.filter(this.state);
            this.props.navigator.dismissModal();
          }}/>  
      </View>
    )
  }

  /**
   * Render tier picker items
   */
  renderTier = () => {
    return tierList.map(function(value, index) {
      return <Picker.Item key={value} label={value} value={index}/>
    })
  }

  /**
   * Render type or nation picker item
   */
  renderOther = (info) => {
    return info.map(function(value, index) {
      return  <Picker.Item key={index} label={value.text} value={value.key}/>
    })
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flexDirection: 'row', alignSelf: 'center',
    marginBottom: 8
  }
})