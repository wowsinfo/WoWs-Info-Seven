import { Theme, DarkTheme, DefaultTheme } from 'react-native-paper';

/**
 * Custom theme (a wrapper around Theme from react native paper)
 * - Dark or light mode
 * - Primary colour
 */
export default class CustomTheme {
  dark!: boolean;
  primary!: string;

  constructor(dark: boolean, primary: string) {
    this.dark = dark;
    this.primary = primary;
  }

  /**
   * Get your custom theme based on your selection
   * @returns a theme object
   */
  getTheme(): Theme {
    const baseTheme = this.dark ? DarkTheme : DefaultTheme;

    // There might be some changes in the future
    return {
      ...baseTheme,
      colors: {
        ...baseTheme.colors,
        primary: this.primary
      }
    };
  }
}
