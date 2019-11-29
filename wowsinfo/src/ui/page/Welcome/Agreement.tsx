import React, { Component } from "react";
import { WoWsComponent } from "src/ui/component/WoWsComponent";
import { Surface, Button, Colors, Portal, Dialog, Paragraph } from "react-native-paper";
import { Actions } from "react-native-router-flux";
import { langs } from "../../../core/value/Language";
import { StyleSheet, Alert } from "react-native";
import { BottomButton } from "../../component";

interface AgreementState {
  visible: boolean
}

class Agreement extends Component<{}, AgreementState> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: {}) {
    super(props);
    
    this.state = {
      visible: false
    };
  }

  showAlert = () => this.setState({visible: true});
  closeAlert = () => this.setState({visible: false});

  render() {
    const { rootView, bottomView, bottomButton } = styles;
    return (
      <Surface style={rootView}>
        <Surface style={bottomView}>
          <Button color={Colors.blue500} style={bottomButton} onPress={() => null}>
            {langs.agreement_agree}
          </Button>
          <Button color={Colors.red500} style={bottomButton} onPress={this.showAlert}>
            {langs.agreement_disagree}
          </Button>
        </Surface>
        <Portal>
          <Dialog visible={this.state.visible} onDismiss={this.closeAlert}>
            <Dialog.Title>WoWs Info</Dialog.Title>
            <Dialog.Content>
              <Paragraph>{langs.agreement_you_have_to_agree}</Paragraph>
            </Dialog.Content>
            <Dialog.Actions>
              <Button onPress={() => Actions.replace('Welcome')}>{langs.agreement_retry}</Button>
            </Dialog.Actions>
          </Dialog>
        </Portal>
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
