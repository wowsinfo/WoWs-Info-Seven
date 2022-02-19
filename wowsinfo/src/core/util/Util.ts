import {lang} from '../../value/lang';
import {Dimensions} from 'react-native';

class Utils {
  /**
   * Deep clone an object
   * @param {any} value
   */
  static copy(value: any): any {
    return JSON.parse(JSON.stringify(value));
  }

  /**
   * Return a number between 0 to range - 1
   * @param {int} range
   */
  static random(range: number): number {
    return Math.floor(Math.random() * range);
  }

  /**
   * Round a number to a specific decimal
   * @param num a number
   * @param digit up to how many digits
   * @returns rounded number
   */
  static roundTo(num: number, digit = 0): number {
    if (isNaN(num) || !isFinite(num)) return Number(-1);
    return Number(Number(num).toFixed(digit));
  }

  /**
   * Get date difference in days
   * @param time
   */
  static dayDifference(time: number): number {
    let timeDiff = Math.abs(Date.now() / 1000 - time);
    return Math.ceil(timeDiff / (3600 * 24));
  }

  /**
   * Get a readable date string
   * @param {*} time
   */
  static humanTimeString(time: number): string {
    if (time == null) return lang.warship_unkown;
    if (time === 0) return `---`;
    let obj = new Date(time * 1000);
    // first part to get date string and the second get locale time
    return `${obj
      .toISOString()
      .slice(0, 10)
      .split('-')
      .join('.')} ${obj.toLocaleTimeString()}`;
  }

  static getRandomAnimation(): string {
    const list = [
      'bounce',
      'flash',
      'pulse',
      'rotate',
      'rubberBand',
      'shake',
      'swing',
      'tada',
      'wobble',
    ];
    return list[Utils.random(list.length)];
  }

  /**
   * Get the best cell width so that there won't be more than 6 items per row
   */
  static bestCellWidth(width: number): number {
    const deviceWidth = Dimensions.get('window').width;
    const usualCount = deviceWidth / width;
    if (usualCount > 6) return deviceWidth / 6;
    return width;
  }

  /**
   * Make sure the item isn't longer than the device,
   * if 2 items cannot be placed just do one
   * @param {number} width
   */
  static bestWidth(width: number, deviceWidth = Utils.currDeviceWidth()) {
    console.log('Utils.bestWidth', width, deviceWidth);
    return deviceWidth / Math.max(1, Number((deviceWidth / width).toFixed(0)));
  }

  static currDeviceWidth(): number {
    return Dimensions.get('window').width;
  }
}

export {Utils};
