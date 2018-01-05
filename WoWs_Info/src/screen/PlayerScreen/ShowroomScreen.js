import React from 'react';
import { WoWsLoading } from '../../component';
import { AchievementScreen } from '../../screen';
import { AchievementInfo } from '../../core';

class ShowroomScreen extends React.PureComponent {
  state = {
    isReady: false,
    data: [],
  }

  componentWillMount() {
    const { id } = this.props;
    let info = new AchievementInfo(id, global.server);
    info.getPlayerAchievement().then(achievement => {
      this.setState({
        isReady: true,
        data: achievement,
      })
    })
  }

  render() {
    const { data, isReady } = this.state;
    if (isReady) return <AchievementScreen info={data}/>
    else return <WoWsLoading />;
  }
}

export {ShowroomScreen};