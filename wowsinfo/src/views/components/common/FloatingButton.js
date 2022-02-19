import React, {Component} from 'react';
import {SafeAreaView, StyleSheet} from 'react-native';
import {FAB} from 'react-native-paper';
import {Actions} from 'react-native-router-flux';

class FloatingButton extends Component {
  constructor(props) {
    super(props);

    let hasMenu = false;
    if (Actions.state.routes.findIndex(r => r.routeName === 'Menu') > 0) {
      hasMenu = true;
    }

    this.state = {
      menu: hasMenu,
      icon: hasMenu ? 'home' : require('../../img/Ship.png'),
    };
  }

  render() {
    const {container} = styles;
    const {icon} = this.state;

    return (
      <SafeAreaView style={container}>
        <FAB onPress={() => this.navigate()} mode="contained" icon={icon} />
      </SafeAreaView>
    );
  }

  /**
   * Navigate to Menu page
   */
  navigate() {
    const {menu} = this.state;
    if (menu) {
      // Pop to menu
      Actions.popTo('Menu');
    } else if (Actions.currentScene !== 'Menu') {
      // Add guard so that it wont push twice]
      Actions.Menu();
    }
  }
}

const styles = StyleSheet.create({
  container: {
    position: 'absolute',
    right: 16,
    bottom: 16,
  },
});

export {FloatingButton};
