import React from 'react';
import { Icon } from 'react-native-elements';
import { StyleSheet } from 'react-native';
import store from 'react-native-simple-store';
import { localDataName } from '../../constant/value';

class AddFriendButton extends React.PureComponent {
  state = {
    isFriend: false,
  }

  componentWillMount() {
    const { name, id, server } = this.props.info;
    let list = global.playerList;
    console.log(list);
    if (list[id] != null) {
      this.setState({
        isFriend: true,
      })
    }
  }

  render() {
    const { isFriend } = this.state;
    if (isFriend) return <Icon type='font-awesome' name='star' color='white' underlayColor='transparent' containerStyle={iconStyle} onPress={this.removeFriend}/>;
    else return <Icon type='font-awesome' name='star-o' color='white' underlayColor='transparent' containerStyle={iconStyle} onPress={this.addFriend}/>;
  }

  addFriend = () => {
    console.log('Add');
    const { name, id, server } = this.props.info;
    global.playerList[id] = {name: name, id: id.toString(), server: server};
    console.log(global.playerList);
    store.save(localDataName.playerList, global.playerList);
    this.setState({
      isFriend: true,
    })
  }

  removeFriend = () => {
    console.log('Remove');    
    const { id } = this.props.info;   
    delete global.playerList[id];
    console.log(global.playerList);
    store.save(localDataName.playerList, global.playerList);
    this.setState({
      isFriend: false,
    })
  }
}

const styles = StyleSheet.create({
  iconStyle: {
    height: 50,
    width: 50,
  }
})
const { iconStyle } = styles;

export {AddFriendButton};