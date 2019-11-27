import { Theme, DarkTheme, DefaultTheme } from 'react-native-paper';

/**
 * Custom theme (a wrapper around Theme from react native paper)
 * - Dark or light mode
 * - Primary colour
 */
export default class CustomTheme {
  private dark!: boolean;
  private primary!: string;

  constructor(dark: boolean, primary: string) {
    this.dark = dark;
    this.primary = primary;
  }

  /**
   * If this theme is a dark theme
   */
  isDarkTheme(): boolean {
    return this.dark;
  }

  /**
   * If this theme is light
   * - Light -> dark text
   * - Not light -> white text
   */
  isLight(): boolean {
    // Dark mode will always be dark
    if (this.dark) return false;

    const c = this.primary.substring(1);
    const rgb = parseInt(c, 16);
    const r = (rgb >> 16) & 0xff;
    const g = (rgb >>  8) & 0xff;
    const b = (rgb >>  0) & 0xff;

    // luma is from 0 to 255, 0 is the darkest and 255 is the brightnes
    const luma = 0.2126 * r + 0.7152 * g + 0.0722 * b;
    return luma > 128 ? true : false;
  }

  /**
   * Get the primary colour
   */
  getPrimary(): string {
    return this.primary;
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
