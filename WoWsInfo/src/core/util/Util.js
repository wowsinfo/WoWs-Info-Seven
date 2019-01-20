import { LOCAL, SERVER } from "../../value/data";

export const getCurrServer = () => {
  return SERVER[DATA[LOCAL.userServer]];
}