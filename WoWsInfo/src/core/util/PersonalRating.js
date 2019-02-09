import { roundTo } from "./Util";

/**
 * Get personal rating for a single ship
 * @param {*} ship 
 */
export const getShipRating = (ship) => {

};

/**
 * Calculate rating for each ship and return an overall rating
 * @param {*} ships 
 */
export const getOverallRating = (ships) => {

};

export const getAP = (rating, battle) => {
  if (battle == 0) return 0;
  else return roundTo(Math.log10(battle) * rating);
}

export const getColour = (rating) => {

};

export const getComment = (rating) => {

};