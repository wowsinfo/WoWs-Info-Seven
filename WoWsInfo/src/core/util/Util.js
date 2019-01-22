import { LOCAL, SERVER } from "../../value/data";

export const getCurrServer = () => {
  return SERVER[DATA[LOCAL.userServer]];
}

export const copy = (value) => {
  return JSON.parse(JSON.stringify(value));
}