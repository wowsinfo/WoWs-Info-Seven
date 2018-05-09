import { LocalData } from '../../constant/value';
import store from 'react-native-simple-store';
import language from '../../constant/language';

class DateCalculator {
  static getCurrDate() {
    return new Date().toDateString();
  }

  /**
   * Day difference between tow dates
   * @param {*} dateBefore 
   * @param {*} dateAfter 
   */
  static diffDate(dateBefore, dateAfter) {
    let before = new Date(dateBefore);
    let after = new Date(dateAfter);
    console.log(before, after);
    let diff = after.getTime() - before.getTime();
    return Math.ceil(diff / (1000 * 3600 * 24));
  }

  /**
   * Date difference to string
   * @param {*} diff 
   */
  static diffToString(diff) {
    let diffDays = parseInt(diff);
    if (diffDays == 0) return language.day_today;
    else if (diffDays == 1) return language.day_yesterday;
    else return diffDays + language.day_old;
  }

  /**
   * Check if it is a new day
   * @param {*} lastOpen 
   */
  static isNewDay(lastOpen) {
    if (lastOpen == null) return;
    let currDate = DateCalculator.getCurrDate();
    console.log('New Day??\n' + lastOpen + '\n' + currDate);
    if (lastOpen == currDate) return false;
    else {
      // Update currDate
      store.save(LocalData.date, currDate);
      return true;
    }
  }

  static shouldUpdateToken(token) {
    if (token == null || token == '') return false;
    let currDate = DateCalculator.getCurrDate();
    let diff = DateCalculator.diffDate(token, currDate);
    // It lasts 20 days
    if (parseInt(diff) > 15) return true;
    return false;
  }
}

export { DateCalculator }