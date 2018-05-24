import React, { Component } from 'react';
import { StyleSheet, Text, Image } from 'react-native';
import { View } from 'react-native-animatable';
import GridView from 'react-native-super-grid';
import ElevatedView from 'react-native-elevated-view';
import { ClanInfo } from '../../core';
import { getTheme, getTextColour, navStyle } from '../../constant/colour';
import { WoWsLoading, WoWsTouchable } from '../../component';
import language from '../../constant/language';
import { GREY } from 'react-native-material-color';
import { iconsMap } from '../../constant/icon';

export default class Clan extends Component {
  constructor(props) {
    super();
    const { id, clanName, server } = props;
    this.state = {
      data: [], member: [], isReady: false
    }

    let clan = new ClanInfo(clanName, id, server);
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
        data: clanInfo, member: memberList, isReady: true     
      })
    })
  }

  render() {
    const { member, isReady } = this.state;
    const { textStyle, clanCellViewStyle } = styles;
    if (isReady) {
      return (
        <View animation='bounceInUp' style={{flex: 1}}>
          <GridView items={member} ListHeaderComponent={this.renderHeader}
          itemDimension={256} renderItem={item => { return (
            <WoWsTouchable onPress={() => {
              this.props.navigator.push({
                title: String(item.id),
                screen: 'search.player',
                backButtonTitle: '',              
                navigatorStyle: navStyle(),
                navigatorButtons: item.id == user_info.id ? null : {
                  rightButtons: friend.find(x => x.id === item.id) 
                    ? [{icon: iconsMap['star'], id: 'star-o'}]
                    : [{icon: iconsMap['star-o'], id: 'star'}]
                },
                passProps: item
              })}}>
              <View style={clanCellViewStyle}><Text style={textStyle}>{'[' + item.id + '] ' + item.name}</Text></View>
            </WoWsTouchable>
          )}}/>
        </View>
      )
    } else return <WoWsLoading />
  }

  renderHeader = () => {
    const { count, created_at, leader_name, name, tag, text} = this.state.data;
    const { clanNameStyle, clanTextStyle, clanLeaderStyle, clanMemberStyle, leaderImage, leaderViewStyle, memberViewStyle } = styles;
    return (
      <View style={{margin: 8, marginTop: 0, flex: 1, backgroundColor: getTheme()}}>
        <Text style={[clanNameStyle, {color: getTextColour(getTheme())}]}>{'[' + tag + '] ' + name}</Text>
        <Text style={[clanTextStyle, {color: getTextColour(getTheme())}]}>{text}</Text>
        <View style={leaderViewStyle}>
          <Image source={require('../../img/Commander.png')} style={leaderImage}/>
          <Text style={[clanLeaderStyle, {color: getTextColour(getTheme())}]}>{leader_name}</Text>
        </View>
        <View style={memberViewStyle}>
          <Text style={[clanMemberStyle, {color: getTextColour(getTheme())}]}>{language.clan_member_count + ' (' + count + ')'}</Text>
          <Image />
        </View>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  clanNameStyle: {
    fontSize: 32,
    fontWeight: 'bold',
    textAlign: 'center',
    margin: 4,
  },
  clanTextStyle: {
    padding: 4,
  },
  clanLeaderStyle: {
    textAlign: 'center',    
    padding: 8,
    fontSize: 24,   
  },
  clanMemberStyle: {
    fontWeight: 'bold',
    textAlign: 'left',        
    fontSize: 24,
    width: '80%',
    padding: 8,
  },
  leaderImage: {
    width: 32,
    height: 32,
  },
  leaderViewStyle: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
  },
  memberViewStyle: {
    flexDirection: 'row',    
  },
  clanCellViewStyle: {
    height: 44, justifyContent: 'center', padding: 8
  },
  textStyle: {
    fontSize: 16, fontWeight: '300',
    color: GREY[900]
  }
})