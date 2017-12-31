import React from 'react';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading, BasicCell } from '../../../component';

class BasicScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }

  componentDidMount() {
    // Prase global.achievementJson and make it readable
    var parsed = [];
    for (key in global.commanderSkillJson) {
      // Make naming unique
      let entry = Object.assign({}, global.commanderSkillJson[key]); var text = '';
      for (var i = 0; i < entry.perks.length; i++) text += entry.perks[i].description + '\n';
      entry.text = text;
      entry.key = key;
      entry.image = entry.icon;
      delete entry.icon;
      delete entry.perks;
      parsed.push(entry);
    }
    // Sort by tier
    parsed.sort(function (a, b) {
      return (a.tier - b.tier);
    })
    console.log(parsed);
    this.setState({
      isReady: true,
      data: parsed,
    }, () => Actions.refresh({title: parsed.length}));
  }

  render() {
    if (this.state.isReady) {
      return (
        <GridView itemDimension={80} items={this.state.data} 
          renderItem={item => <BasicCell icon={item.image} data={item}/>} />
      )
    } else return <WoWsLoading />;
  }
}

export {BasicScreen};