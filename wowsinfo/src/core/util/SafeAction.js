import {Actions} from 'react-native-router-flux';

// Add safe action to check if that screen already exists in the stack
// max is for the case where you need to push another same screen
export const SafeAction = (screen, obj, max = 0) => {
  if (Actions.state.routes.filter(r => r.routeName === screen).length > max) {
    console.log(`${screen} rejected`);
  } else {
    Actions.push(screen, obj);
    console.log(`${screen} pushed`);
  }
};
