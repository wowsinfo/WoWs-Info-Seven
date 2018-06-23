import React, { Component } from 'react';
import { AchievementInfo } from '../../core';
import { Achievement } from '../';
import { WoWsLoading } from '../../component';

class AchievementScreen extends Component {
  state = {
    isReady: false, data: []
  }

  componentWillMount() {
    const { id, server } = this.props;
    let info = new AchievementInfo(id, server);
    info.getPlayerAchievement().then(achievement => {
      this.setState({
        isReady: true, data: achievement
      })
    })
  }

  render() {
    const { data, isReady } = this.state;
    if (isReady) return <Achievement info={data}/>
    else return <WoWsLoading />;
  }
}

export { AchievementScreen };