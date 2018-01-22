import React, { Component } from 'react';
import { StyleSheet, Platform } from 'react-native';
import { Router, Scene, Actions } from 'react-native-router-flux';
import { SearchButton, PlayerOnlineButton } from '../component';
import { SearchScreen, PlayerOnlineScreen, AchievementScreen, MapScreen, ShipScreen, NewsScreen, InAppBrowser, MapDetailScreen, ShipDetailScreen, BasicScreen, BasicDetailScreen, CollectionDetailScreen, RankDetailScreen, ClanScreen } from '../screen';
import { MainTab, PlayerTab } from '../tab/';
import strings from '../localization';
import { Icon } from 'react-native-elements';
import { ThemeScreen } from '../screen/SettingsScreen/ThemeScreen';

var appTitle = 'WoWs Info ';
switch (Platform.OS) {
  case 'ios': appTitle += 'X'; break;
  case 'android': appTitle += 'Y'; break;
  case 'windows': appTitle += 'Z'; break;
  default: break;
}

class MainRouter extends Component {
  render() {
    return (
      <Router sceneStyle={sceneStyle} backAndroidHandler={this.onBackPress}>
        <Scene key='root' headerTintColor='white' backTitle='' leftButtonTextStyle={{color: 'white'}} titleStyle={titleStyle} 
          navigationBarStyle={{backgroundColor: global.themeColour}}>
          <Scene key='MainScreen' {...this.props} title={appTitle} component={MainTab} navigationBarStyle={{backgroundColor: global.themeColour, elevation: 0}}
            renderRightButton={ <SearchButton onPress={() => Actions.SearchScreen()}/> }
            renderLeftButton={ <PlayerOnlineButton onPress={() => Actions.PlayerOnlineScreen()}/> }/>
          <Scene key='PlayerScreen' component={PlayerTab} navigationBarStyle={{backgroundColor: global.themeColour, elevation: 0}}/>
          <Scene key='ClanScreen' component={ClanScreen}/>

          <Scene key='SearchScreen' component={SearchScreen}/>
          <Scene key='NewsScreen' component={NewsScreen}/>          
          <Scene key='ThemeScreen' component={ThemeScreen}/>          
          
          <Scene key='BasicScreen' component={BasicScreen}/>          
          <Scene key='AchievementScreen' component={AchievementScreen}/>
          <Scene key='MapScreen' component={MapScreen}/>
          <Scene key='ShipScreen' component={ShipScreen}/>

          <Scene key='BasicDetailScreen' component={BasicDetailScreen}/>
          <Scene key='MapDetailScreen' component={MapDetailScreen}/>
          <Scene key='CollectionDetailScreen' component={CollectionDetailScreen}/>
          
          <Scene key='ShipDetailScreen' component={ShipDetailScreen}/>
          <Scene key='RankDetailScreen' component={RankDetailScreen}/>
          
          <Scene key='PlayerOnlineScreen' component={PlayerOnlineScreen}/>
          <Scene key='InAppBrowser' component={InAppBrowser}/>
        </Scene>
      </Router>
    )
  }
  
  onBackPress = () => {
    if (Actions.state.index == 0) return false;
    else Actions.pop(); return true;
  }
}

const styles = StyleSheet.create({
  titleStyle: {
    color: 'white',
    width: '90%',
  },
  sceneStyle: {
    backgroundColor: 'white',
  },
  iconStyle: {
    padding: 10,
  }
});
const { titleStyle, sceneStyle, iconStyle } = styles;

export {MainRouter};