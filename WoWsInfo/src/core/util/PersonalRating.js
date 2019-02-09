import { roundTo } from "./Util";
import { SafeValue } from "./SafeGuard";
import { SAVED } from "../../value/data";
import lang from "../../value/lang";

const getOverall = (id) => DATA[SAVED.pr][id];

const calRating = (actualDmg, expectedDmg, actualWins, expectedWins, actualFrags, expectedFrags) => {
  // From https://wows-numbers.com/personal/rating by Wiochi
  const rDmg = actualDmg / expectedDmg;
  const rWins = actualWins / expectedWins;
  const rFrags = actualFrags / expectedFrags;

  const nDmg = Math.max(0, (rDmg - 0.4) / (1 - 0.4));
  const nFrags = Math.max(0, (rFrags - 0.1) / (1 - 0.1));
  const nWins = Math.max(0, (rWins - 0.7) / (1 - 0.7));

  let rating = roundTo(700 * nDmg + 300 * nFrags + 150 * nWins);
  if (rating == 0) rating = -1;
  return rating;
};

/**
 * Calculate rating for each ship and return an overall rating
 * @param {*} ships 
 */
export const getOverallRating = (ships) => {
  if (ships == null) return -1;

  let actualDmg = 0, expectedDmg = 0, actualWins = 0, expectedWins = 0, actualFrags = 0, expectedFrags = 0;
  for (let ship of ships) {
    const pvp = SafeValue(ship.pvp, null);
    if (pvp) {
      const overall = getOverall(ship.ship_id);
      if (overall == null) continue;

      const { battles, damage_dealt, frags, wins } = pvp;
      const { average_damage_dealt, average_frags, win_rate } = overall;
      
      if (battles == 0) continue;
      let currAvgDmg = damage_dealt / battles;
      let currWinrate = wins / battles * 100;
      let currFrags = frags / battles;

      // Accumulate data
      actualDmg += currAvgDmg;
      actualWins += currWinrate;
      actualFrags += currFrags;
      expectedDmg += average_damage_dealt;
      expectedWins += win_rate;
      expectedFrags += average_frags;

      // Calculate rating and ap
      let rating = calRating(currAvgDmg, average_damage_dealt, currWinrate, win_rate, currFrags, average_frags);
      ship.rating = rating;
      ship.ap = getAP(rating, battles);
    }
  }

  return calRating(actualDmg, expectedDmg, actualWins, expectedWins, actualFrags, expectedFrags);
};

export const getAP = (rating, battle) => {
  if (rating == -1 || battle == 0) return -1;
  else return roundTo(Math.log10(battle) * rating);
}

export const getRatingIndex = (rating) => {
  if (rating < 750) return 0;
  if (rating < 1100) return 1;
  if (rating < 1350) return 2;
  if (rating < 1550) return 3;
  if (rating < 1750) return 4;
  if (rating < 2100) return 5;
  if (rating < 2450) return 6;
  return 7;
}

export const getColour = (rating) => {
  const colours = ['red', 'orange', '#F5C84C', '#67AF34', '#4A7D23', 'cyan', 'magenta', 'purple'];
  return colours[getRatingIndex(rating)];
};

export const getComment = (rating) => {
  const comments = [lang.rating_bad, lang.rating_below_average, lang.rating_average, lang.rating_good, 
                    lang.rating_very_good, lang.rating_great, lang.rating_unicum, lang.rating_super_unicum];
  return comments[getRatingIndex(rating)];
};