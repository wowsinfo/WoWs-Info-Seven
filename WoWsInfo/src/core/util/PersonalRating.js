import { roundTo } from "./Util";
import { SafeValue } from "./SafeGuard";
import { SAVED } from "../../value/data";

const getOverall = (id) => DATA[SAVED.pr][id];

const calRating = (actualDmg, expectedDmg, actualWins, expectedWins, actualFrags, expectedFrags) => {
  // From https://wows-numbers.com/personal/rating by Wiochi
  const rDmg = actualDmg / expectedDmg;
  const rWins = actualWins / expectedWins;
  const rFrags = actualFrags / expectedFrags;

  const nDmg = Math.max(0, (rDmg - 0.4) / (1 - 0.4));
  const nFrags = Math.max(0, (rFrags - 0.1) / (1 - 0.1));
  const nWins = Math.max(0, (rWins - 0.7) / (1 - 0.7));

  return 700 * nDmg + 300 * nFrags + 150 * nWins;
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

export const getColour = (rating) => {

};

export const getComment = (rating) => {

};