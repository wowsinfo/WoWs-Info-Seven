import {roundTo} from './Util';
import {SafeValue} from './SafeGuard';
import {SAVED} from '../../value/data';
import {lang} from '../../value/lang';

const getOverall = id => DATA[SAVED.pr][id];

const calRating = (
  actualDmg,
  expectedDmg,
  actualWins,
  expectedWins,
  actualFrags,
  expectedFrags,
) => {
  // From https://wows-numbers.com/personal/rating by Wiochi
  const rDmg = actualDmg / expectedDmg;
  const rWins = actualWins / expectedWins;
  const rFrags = actualFrags / expectedFrags;

  const nDmg = Math.max(0, (rDmg - 0.4) / (1 - 0.4));
  const nFrags = Math.max(0, (rFrags - 0.1) / (1 - 0.1));
  const nWins = Math.max(0, (rWins - 0.7) / (1 - 0.7));

  let rating = roundTo(700 * nDmg + 300 * nFrags + 150 * nWins);
  // Cap it to 9999
  return Math.min(Number(rating), 9999);
};

/**
 * Calculate rating for each ship and return an overall rating
 * @param {*} ships
 */
export const getOverallRating = ships => {
  if (ships == null) return -1;

  let actualDmg = 0,
    expectedDmg = 0,
    actualWins = 0,
    expectedWins = 0,
    actualFrags = 0,
    expectedFrags = 0;
  for (let ship of ships) {
    ship.rating = -1;
    ship.ap = 0;

    const pvp = SafeValue(ship.pvp, null);
    if (pvp) {
      const overall = getOverall(ship.ship_id);
      if (overall == null) continue;

      const {battles, damage_dealt, frags, wins} = pvp;
      const {average_damage_dealt, average_frags, win_rate} = overall;

      if (battles == 0) continue;
      let currAvgDmg = damage_dealt / battles;
      let currWinrate = (wins / battles) * 100;
      let currFrags = frags / battles;
      ship.avgDmg = currAvgDmg;
      ship.avgWinrate = currWinrate;
      ship.avgFrags = currFrags;

      // Accumulate data
      actualDmg += currAvgDmg;
      actualWins += currWinrate;
      actualFrags += currFrags;
      expectedDmg += average_damage_dealt;
      expectedWins += win_rate;
      expectedFrags += average_frags;

      // Calculate rating and ap
      let rating = calRating(
        currAvgDmg,
        average_damage_dealt,
        currWinrate,
        win_rate,
        currFrags,
        average_frags,
      );
      ship.rating = rating;
      ship.ap = getAP(rating, battles);
    }
  }

  return calRating(
    actualDmg,
    expectedDmg,
    actualWins,
    expectedWins,
    actualFrags,
    expectedFrags,
  );
};

export const getAP = (rating, battle) => {
  if (rating == -1 || battle == 0) return 0;
  else return Number(roundTo(Math.log10(Math.max(10, battle)) * rating));
};

export const getRatingRange = () => [
  0, 750, 1100, 1350, 1550, 1750, 2100, 2450, 9999,
];
export const getRatingIndex = rating => {
  let index = 0;
  for (let range of getRatingRange()) {
    if (rating < range) return index;
    index++;
  }
};

export const getColourList = () => [
  '#607D8B',
  'red',
  'orange',
  '#F5C84C',
  '#67AF34',
  '#4A7D23',
  '#60C6B3',
  'magenta',
  'purple',
  'black',
];

export const getColour = rating => {
  const colours = getColourList();
  return SafeValue(colours[getRatingIndex(rating)], '#607D8B');
};

export const getRatingList = () => [
  lang.rating_Unkwown,
  lang.rating_bad,
  lang.rating_below_average,
  lang.rating_average,
  lang.rating_good,
  lang.rating_very_good,
  lang.rating_great,
  lang.rating_unicum,
  lang.rating_super_unicum,
];

export const getComment = rating => {
  const comments = getRatingList();

  let index = getRatingIndex(rating);
  let comment = comments[index];
  let range = getRatingRange()[index];

  let diff = range - rating;
  // Prevent big numbers
  if (range === 9999) diff = rating - 2450;

  return `${comment} (+${diff})`;
};
