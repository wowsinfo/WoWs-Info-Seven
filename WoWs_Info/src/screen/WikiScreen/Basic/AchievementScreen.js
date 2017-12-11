import React from 'react';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading, BasicCell } from '../../../component';

class AchievementScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }

  componentWillMount() {
    // Prase global.achievementJson and make it readable
    var parsed = [];
    for (key in global.achievementJson) parsed.push(global.achievementJson[key]);
    // Sort by hidden
    parsed.sort(function (a, b) {
      if (a.hidden) return 1;
      return -1;
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
        <GridView itemDimension={90} items={this.state.data} 
          renderItem={item => <BasicCell icon={item.image}/>} />
      )
    } else return <WoWsLoading />;
  }
}

export {AchievementScreen};