import React from 'react';
import { StyleSheet, Text, View, Animated } from 'react-native';

interface AppTitleState {
  // label 1
  fade1: Animated.Value;
  top1: Animated.Value;
  text1: string;
  // Label 2
  fade2: Animated.Value;
  top2: Animated.Value;
  text2: string;
}

export interface AppTitleProps {

}

class AppTitle extends React.Component<AppTitleProps, AppTitleState> {
  index: number = 1;
  words: string[] = [
    // '1',
    // '2',
    // '3',
    // '4',
    // '5',
    'RE',
    'Origin',
    'Ultimate',
    'Pro',
    'Gold',
    'Ultra',
    '^_^',
    '★',
    'α',
    'θ',
    'Ω',
    'Ф',
    '∞',
    '░',
    '( ͡° ͜ʖ ͡°)',
    '¯_(ツ)_/¯',
  ];
  length: number = this.words.length;
  looper?: number;

  constructor(props: AppTitleProps) {
    super(props);

    this.shuffleArray(this.words);

    this.state = {
      // Label 1
      fade1: new Animated.Value(1),
      top1: new Animated.Value(0),
      text1: this.words[0],
      // Label 2
      fade2: new Animated.Value(0),
      top2: new Animated.Value(20),
      text2: this.words[1],
    };
  }

  /**
   * from https://stackoverflow.com/a/12646864
   * @param {*} array a list of string
   */
  shuffleArray(array: string[]) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
  }

  render() {
    this.animate();

    const { center, t1, t2, shift, root } = styles;
    const { fade1, top1, text1, fade2, top2, text2 } = this.state;
    return (
      <View style={root}>
        <View style={shift}>
          <Text>WoWs Info</Text>
          <View style={center}>
            <Animated.Text style={[t1, { top: top1, opacity: fade1 }]}>
              {text1}
            </Animated.Text>
            <Animated.Text style={[t2, { top: top2, opacity: fade2 }]}>
              {text2}
            </Animated.Text>
          </View>
        </View>
      </View>
    );
  }

  animate = () => {
    const shift_animation = Animated.parallel([
      // Move label 1 up and fade out
      Animated.timing(this.state.fade1, {
        toValue: 0,
      }),
      Animated.timing(this.state.top1, {
        toValue: -20,
      }),
      // MOve label 2 up and fade in
      Animated.timing(this.state.fade2, {
        toValue: 1,
      }),
      Animated.timing(this.state.top2, {
        toValue: 0,
      }),
    ]);

    shift_animation.start(() => {      
      // Update index
      if (this.looper) clearTimeout(this.looper);
      this.looper = setTimeout(() => {
        // Reset and loop
        const { fade1, fade2, top1, top2, text2 } = this.state;
        fade1.setValue(1);
        fade2.setValue(0);
        top1.setValue(0);
        
        top2.setValue(20);
        if (this.index + 1 >= this.words.length) {
          this.index = 0;
          this.setState({
            text1: text2,
            text2: this.words[0],
          });
        } else {
          this.setState({
            text1: text2,
            text2: this.words[++this.index],
          });
        }
      }, 2000);
    });
  };
}

const styles = StyleSheet.create({
  root: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  shift: {
    flexDirection: 'row',
  },
  center: {
    justifyContent: 'center',
    alignItems: 'center',
  },
  t1: {
    position: 'absolute',
    left: 4,
  },
  t2: {
    position: 'absolute',
    left: 4,
  },
});

export { AppTitle };
