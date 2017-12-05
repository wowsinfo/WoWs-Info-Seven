import { localDataName } from '../../constant/value';
import { StorageManager } from './';
import strings from '../../localization'; 

class DateCalculator {
  static getCurrDate() {
    return new Date().toDateString();
  }

  static diffDate(dateBefore, dateAfter) {
    let before = new Date(dateBefore);
    let after = new Date(dateAfter);
    let diff = after.getTime() - before.getTime();
    return Math.ceil(diff / (1000 * 3600 * 24));
  }

  // Convert date difference to string
  static diffToString(diff) {
    let diffDays = parseInt(diff);
    if (diffDays == 0) {
      // Today
      return strings.today;
    } else if (diffDays == 1) {
      // Yesterday
      return strings.yesterday;
    } else {
      // xx days ago
      return diffDays + strings.days_ago;
    }
  }

  static isNewDay(lastOpen) {
    if (lastOpen == null) return;
    let currDate = DateCalculator.getCurrDate();
    console.log('New Day\n' + lastOpen + '\n' + currDate);
    if (lastOpen == currDate) return false;
    else {
      // Update currDate
      StorageManager.setItem(localDataName.currDate, currDate);
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

export {DateCalculator}