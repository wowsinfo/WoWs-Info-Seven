import React from 'react';
import { View, Text, Image, FlatList } from 'react-native';
import { SearchResultCell, WoWsLoading } from '../../component';
import { ClanInfo } from '../../core/';
import { styles } from './ClanScreenStyles';
import strings from '../../localization';

class ClanScreen extends React.PureComponent {
  constructor(props) {
    super();
    const {id, clanName, server} = props;
    this.state = {
      data: [],
      member: [],
      isReady: false,
    }

    let clan = new ClanInfo(clanName + '|' + id + '|' + server);
    clan.Search().then(info => {
      let clanInfo = ClanInfo.getInfoFrom(info, id);
      var memberList = [];
      for (key in clanInfo.members) {
        let curr = clanInfo.members[key];
        curr.id = curr.account_id; delete curr.account_id;
        curr.name = curr.account_name; delete curr.account_name;
        curr.server = global.server;
        delete curr.joined_at;
        memberList.push(curr);
      }
      memberList.sort(function (a, b) { return a.role > b.role ? 1 : -1 });
      this.setState({
        data: clanInfo,
        member: memberList,
        isReady: true,        
      })
    })
  }

  keyExtractor = (item) => {return item.id}  
  render() {
    if (this.state.isReady) {
      return (
        <FlatList data={this.state.member} keyExtractor={this.keyExtractor} ListHeaderComponent={this.renderHeader}
          renderItem={({item}) => <SearchResultCell data={item} role={true}/>}/>
      )
    } else return <WoWsLoading />
  }

  renderHeader = () => {
    console.log(this.state.data);
    const { count, created_at, leader_name, name, tag, text} = this.state.data;
    const { clanNameStyle, clanTextStyle, clanLeaderStyle, clanMemberStyle, leaderImage, leaderViewStyle, memberViewStyle } = styles;
    return (
      <View style={{flex: 1, backgroundColor: global.themeColour}}>
        <Text style={clanNameStyle}>{'[' + tag + '] ' + name}</Text>
        <Text style={clanTextStyle}>{text}</Text>
        <View style={leaderViewStyle}>
          <Image source={require('../../img/Commander.png')} style={leaderImage}/>
          <Text style={clanLeaderStyle}>{leader_name}</Text>
        </View>
        <View style={memberViewStyle}>
          <Text style={clanMemberStyle}>{strings.member_count + ' (' + count + ')'}</Text>
          <Image />
        </View>
      </View>
    )
  }
}

export {ClanScreen};