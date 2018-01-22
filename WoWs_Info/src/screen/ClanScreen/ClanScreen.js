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
          renderItem={({item}) => <SearchResultCell data={item}/>}/>
      )
    } else return <WoWsLoading />
  }

  renderHeader = () => {
    console.log(this.state.data);
    const { count, created_at, leader_name, name, tag, text} = this.state.data;
    const { clanNameStyle, clanTextStyle, clanLeaderStyle, clanMemberStyle } = styles;
    return (
      <View style={{flex: 1, backgroundColor: global.themeColour}}>
        <Text style={clanNameStyle}>{'[' + tag + '] ' + name}</Text>
        <Text style={clanTextStyle}>{text}</Text>
        <View>
          <Image />
          <Text style={clanLeaderStyle}>{leader_name}</Text>
        </View>
        <View>
          <Text style={clanMemberStyle}>{strings.member_count + '(' + count + ')'}</Text>
          <Image />
        </View>
      </View>
    )
  }
}

export {ClanScreen};