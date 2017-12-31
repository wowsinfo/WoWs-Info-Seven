import React from 'react';
import GridView from 'react-native-super-grid';
import { Actions } from 'react-native-router-flux';
import { WoWsLoading, BasicCell } from '../../../component';

class AchievementScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }

  componentDidMount() {
    // Prase global.achievementJson and make it readable
    var parsed = []; let json = global.achievementJson;
    for (key in json) parsed.push(json[key]);
    // Sort by hidden
    parsed.sort(function (a, b) {
      if (a.hidden == b.hidden) return (a.name < b.name) ? 1 : -1;
      else return (a.hidden > b.hidden) ? 1 : -1;
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
          renderItem={item => {
            if (!item.hidden) return <BasicCell icon={item.icon} data={item}/>
            else return <BasicCell icon={item.icon_inactive} data={item}/>
          }} />
      )
    } else return <WoWsLoading />;
  }
}

export {AchievementScreen};