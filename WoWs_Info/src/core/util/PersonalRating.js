import strings from '../../localization';
import { PersonalRating } from '../../colour/colour';

class PersonalRating {
  constructor(id, battle, damage, frag, win) {
    let ship = global.personalRatingJson[id];
    if (ship == null) {
      // This ship id is valid
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
    }
  }

  getRating() {
    let rDmg = this.avg_damage / ship.average_damage_dealt;
    let rWins = this.win_rate / ship.win_rate;
    let rFrags = this.avg_frag / ship.average_frags;

    let nDmg = Math.max(0, (rDmg - 0.4) / (1 - 0.4));
    let nFrags = Math.max(0, (rFrags - 0.1) / (1 - 0.1));
    let nWins = Math.max(0, (rWins - 0.7) / (1 - 0.7));

    return 700 * nDMG + 300 * nFrags + 150 * nWins;
  }

  getIndex(pr) {
    if (pr < 750) return 0;
    if (pr < 1100) return 1;
    if (pr < 1350) return 2;
    if (pr < 1550) return 3;
    if (pr < 1750) return 4;
    if (pr < 2100) return 5;
    if (pr < 2450) return 6;
    return 7;
  }

  getColour(index) {
    let colour = [PersonalRating.ImprovementNeeded, PersonalRating.BelowAverage, PersonalRating.Average, PersonalRating.Good, PersonalRating.VeryGood, PersonalRating.Great, PersonalRating.Unicum, PersonalRating.SuperUnicum];
    return colour[index];
  }

  getComment(index) {
    let comment = [strings.improvement_needed, strings.below_average, strings.average, strings.good, strings.very_good, strings.great, strings.unicum, strings.super_unicum];
    return comment[index];
  }
}

export {PersonalRating};