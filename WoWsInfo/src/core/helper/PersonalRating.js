import strings from '../../localization';
import { PR } from '../../colour/colour';

class PersonalRating {
  constructor(id, battle, damage, win, frag) {
    this.ship = data.personal_rating[id];
    if (this.ship != null && this.ship.win_rate != null) {
      // This ship id is valid
      this.battle = battle;
      if (battle > 0) {
        this.avg_damage = damage / battle;
        this.win_rate = win / battle * 100;
        this.avg_frag = frag / battle;
      } else {
        // No battle no rating
        this.avg_damage = 0;
        this.win_rate = 0;
        this.avg_frag = 0;
      }

      // Calculate rating
      let rDmg = this.avg_damage / this.ship.average_damage_dealt;
      let rWins = this.win_rate / this.ship.win_rate;
      let rFrags = this.avg_frag / this.ship.average_frags;
  
      let nDmg = Math.max(0, (rDmg - 0.4) / (1 - 0.4));
      let nFrags = Math.max(0, (rFrags - 0.1) / (1 - 0.1));
      let nWins = Math.max(0, (rWins - 0.7) / (1 - 0.7));
  
      this.rating = 700 * nDmg + 300 * nFrags + 150 * nWins;
    } else this.rating = 1;
  }

  /**
   * @return get ship rating
   */
  getRating() {
    return this.rating;
  }

  /**
   * @return get ability point
   */
  getAbilityPoint() {
    return Math.log10(this.battle) * this.rating;
  }

  static getIndex(pr) {
    if (pr < 750) return 0;
    if (pr < 1100) return 1;
    if (pr < 1350) return 2;
    if (pr < 1550) return 3;
    if (pr < 1750) return 4;
    if (pr < 2100) return 5;
    if (pr < 2450) return 6;
    return 7;
  }

  static getColour(index) {
    let colour = [PR.ImprovementNeeded, PR.BelowAverage, PR.Average, PR.Good, PR.VeryGood, PR.Great, PR.Unicum, PR.SuperUnicum];
    return colour[index];
  }

  static getComment(index) {
    let comment = [strings.improvement_needed, strings.below_average, strings.average, strings.good, strings.very_good, strings.great, strings.unicum, strings.super_unicum];
    return comment[index];
  }

  static getTotalRating(dmg, avg_dmg, win, avg_win, frag, avg_frag) {
    let rDmg = dmg / avg_dmg;
    let rWins = win / avg_win;
    let rFrags = frag / avg_frag;

    let nDmg = Math.max(0, (rDmg - 0.4) / (1 - 0.4));
    let nFrags = Math.max(0, (rFrags - 0.1) / (1 - 0.1));
    let nWins = Math.max(0, (rWins - 0.7) / (1 - 0.7));

    return 700 * nDmg + 300 * nFrags + 150 * nWins;
  }
}

export { PersonalRating };