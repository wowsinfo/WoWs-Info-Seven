import { LOCAL, SERVER } from "../../value/data";

export const getCurrServer = () => {
  return SERVER[DATA[LOCAL.userServer]];
}

export const copy = (value) => {
  return JSON.parse(JSON.stringify(value));
}

/**
 * Return a number between 0 to range - 1
 * @param {int} range 
 */
export const random = (range) => {
  return Math.floor(Math.random() * range);
}