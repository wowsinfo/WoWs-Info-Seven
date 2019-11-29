import React, { Component } from "react";
import { WoWsComponent } from "src/ui/component/WoWsComponent";
import { Surface, Button, Colors } from "react-native-paper";
import { Actions } from "react-native-router-flux";
import { langs } from "../../../core/value/Language";
import { StyleSheet } from "react-native";
import { BottomButton } from "../../component";

class Agreement extends Component implements WoWsComponent {
  isProFeature: boolean = false;

  render() {
    const { rootView, bottomView, bottomButton } = styles;
    return (
      <Surface style={rootView}>
        <Surface style={bottomView}>
          <Button color={Colors.blue500} style={bottomButton} onPress={() => null}>
            Hello
          </Button>
          <Button color={Colors.red500} style={bottomButton} onPress={() => null}>
            World
          </Button>
        </Surface>
      </Surface>
    )
  }
}

const styles = StyleSheet.create({
  rootView: {
    flex: 1
  },
  bottomView: {
    flex: 1,
    padding: 16,
    flexDirection: 'row',
    alignItems: 'flex-end',
    justifyContent: 'center'
  },
  bottomButton: {
    flex: 1
  }
});

export { Agreement };
