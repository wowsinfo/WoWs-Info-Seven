import React from 'react';
import { StyleSheet, Text, View, Animated, StyleProp } from 'react-native';

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
  /**
   * A list of titles
   */
  titles: string[],
  /**
   * Style of the title
   */
  titleStyle?: StyleProp<Text>,
  /**
   * Render anything before the title
   */
  prefix?: JSX.Element,
  /**
   * How fast should the title update in milliseconds
   */
  frequency?: number,
  /**
   * Whether `titles` should be shown in random orders
   * - True by default
   */
  shuffle?: boolean,
}

class AppTitle extends React.Component<AppTitleProps, AppTitleState> {
  private index: number = 1;
  private words: string[];
  private length: number;
  private frequency: number = 2000;
  private looper?: number;

  constructor(props: AppTitleProps) {
    super(props);

    this.words = props.titles;
    this.length = this.words.length;
    // Shuffle the array
    if (props.shuffle != false) this.shuffleArray(this.words);
    if (props.frequency) this.frequency = props.frequency;

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
  private shuffleArray(array: string[]) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
  }

  render() {
    this.animate();

    const { prefix, titleStyle } = this.props;
    const { center, shift, t, root } = styles;
    const { fade1, top1, text1, fade2, top2, text2 } = this.state;

    // Create style of text1 and text2
    const t1Style = StyleSheet.flatten([t, { top: top1, opacity: fade1 }, titleStyle]);
    const t2Style = StyleSheet.flatten([t, { top: top2, opacity: fade2 }, titleStyle]);

    return (
      <View style={root}>
        <View style={shift}>
          { prefix }
          <View style={center}>
            <View>
              <Animated.Text style={t1Style}>
                {text1}
              </Animated.Text>
              <Animated.Text style={t2Style}>
                {text2}
              </Animated.Text>
            </View>
          </View>
        </View>
      </View>
    );
  }

  /**
   * Shifting animation
   */
  private animate = () => {
    const shift_animation = Animated.parallel([
      // Move label 1 up and fade out
      Animated.timing(this.state.fade1, {
        toValue: 0,
      }),
      Animated.timing(this.state.top1, {
        toValue: -20,
      }),
      // Move label 2 up and fade in
      Animated.timing(this.state.fade2, {
        toValue: 1,
      }),
      Animated.timing(this.state.top2, {
        toValue: 0,
      }),
    ]);

    shift_animation.start(() => {      
      // Clean up timeouts
      if (this.looper) clearTimeout(this.looper);
      this.looper = setTimeout(() => {
        // Reset and loop
        const { fade1, fade2, top1, top2, text2 } = this.state;
        fade1.setValue(1);
        fade2.setValue(0);
        top1.setValue(0);
        top2.setValue(20);

        // Update index
        if (this.index + 1 >= this.length) {
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
      }, this.frequency);
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
    justifyContent: 'center',
    alignItems: 'center',

  },
  center: {
    top: -10,
    bottom: 10
  },
  t: {
    position: 'absolute',
    left: 4,
  },
});

export { AppTitle };
