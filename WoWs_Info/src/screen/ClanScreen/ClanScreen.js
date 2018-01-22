import React from 'react';
import { View, Text, Image, FlatList } from 'react-native';
import { SearchResultCell } from '../../component';
import { ClanInfo } from '../../core/';

class ClanScreen extends React.PureComponent {
  constructor(props) {
    super();
    const {id, clanName, server} = props;
    this.state = {
      data: [],
      member: []
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
      })
    })
  }

  keyExtractor = (item) => {return item.id}  
  render() {
    return (
      <FlatList data={this.state.member} keyExtractor={this.keyExtractor} automaticallyAdjustContentInsets={false}
        renderItem={({item}) => <SearchResultCell data={item}/>} renderHeader={this.renderHeader}/>
    )
  }

  renderHeader = () => {
    return (
      <View>
        <Text></Text>
        <Text></Text>
        <View>
          <Image />
          <Text></Text>
        </View>
        <View>
          <Text></Text>
          <Image />
        </View>
      </View>
    )
  }
}

export {ClanScreen};