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

  static isNewDay() {
    let lastOpenDate = StorageManager.getItem(localDataName.currDate).then(date => {
      let currDate = DateCalculator.getCurrDate();
      console.log(date + '\n' + currDate);
      if (lastOpenDate == currDate) return false;
      else {
        // Update currDate
        StorageManager.setItem(localDataName.currDate, currDate);
        return true;
      }
    })
  }

  static shouldUpdateToken() {
    let lastTokenDate = StorageManager.getItem(localDataName.tokenDate).then(token => {
      if (token == '') return false;
      let currDate = DateCalculator.getCurrDate();
      let diff = DateCalculator.diffDate(token, currDate);
      // It lasts 20 days
      if (parseInt(diff) > 15) return true;
      return false;
    })
  }
}

export {DateCalculator}