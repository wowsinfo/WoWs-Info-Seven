import React from 'react';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading, BasicCell } from '../../../component';

class CommanderScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }

  componentWillMount() {
    // Prase global.achievementJson and make it readable
    var parsed = [];
    for (key in global.commanderSkillJson) parsed.push(global.commanderSkillJson[key]);
    // Sort by tier
    parsed.sort(function (a, b) {
      return (a.tier - b.tier);
    })
   // console.log(parsed);
    this.setState({
      isReady: true,
      data: parsed,
    }, () => Actions.refresh({title: parsed.length}));
  }

  render() {
    if (this.state.isReady) {
      return (
        <GridView itemDimension={80} items={this.state.data} 
          renderItem={item => <BasicCell icon={item.icon}/>} />
      )
    } else return <WoWsLoading />;
  }
}

export {CommanderScreen};