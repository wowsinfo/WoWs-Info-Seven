import React, { Component } from "react";
import { WoWsComponent } from "../WoWsComponent";
import { StyleSheet } from "react-native";
import { Button } from "react-native-paper";

export interface BottomButtonProps {
  onPress?: (() => void),
  children: React.ReactNode,
}

/**
 * A button at the bottom with 16px margin
 */
class BottomButton extends Component<BottomButtonProps> implements WoWsComponent {
  isProFeature: boolean = false;

  constructor(props: BottomButtonProps) {
    super(props);
  }

  render() {
    const { children, onPress } = this.props;
    return (
      <Button style={styles.bottomBtn} onPress={onPress}>
        {children}
      </Button>
    );
  }
}

const styles = StyleSheet.create({
  bottomBtn: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    margin: 16
  }
});

export { BottomButton };
