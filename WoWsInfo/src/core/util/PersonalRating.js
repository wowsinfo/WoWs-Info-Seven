import { roundTo } from "./Util";
import { Guard } from "./SafeGuard";

/**
 * Get personal rating for a single ship
 * @param {*} ship 
 */
export const getShipRating = (ship) => {
  if (ship == null) return -1;
  // Damage, WinRate and Frags
  const { battles, damage_dealt, frags, wins } = ship;
};

/**
 * Calculate rating for each ship and return an overall rating
 * @param {*} ships 
 */
export const getOverallRating = (ships) => {
  if (ships == null) return -1;
  for (let ship of ships) {
    let rating = getShipRating(ship.pvp);
    ship.rating = rating;
    const battle = Guard(ship, 'pvp.battles', 0);
    ship.ap = getAP(rating, battle);

    // Accumulate damage, winrate and frags
  }
};

export const getAP = (rating, battle) => {
  if (battle == 0) return -1;
  else return roundTo(Math.log10(battle) * rating);
}

export const getColour = (rating) => {

};

export const getComment = (rating) => {

};