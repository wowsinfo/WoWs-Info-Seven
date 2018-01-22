import { StyleSheet } from 'react-native';

export const styles = StyleSheet.create({
  clanNameStyle: {
    color: 'white',
    fontSize: 32,
    fontWeight: 'bold',
    textAlign: 'center',
    margin: 4,
  },
  clanTextStyle: {
    color: 'white',
    padding: 4,
  },
  clanLeaderStyle: {
    color: 'white', 
    textAlign: 'center',    
    padding: 8,
    fontSize: 24,   
  },
  clanMemberStyle: {
    color: 'white',
    fontWeight: 'bold',
    textAlign: 'center',        
    fontSize: 24,
    padding: 8,
  },
  leaderImage: {
    width: 32,
    height: 32,
  },
  leaderViewStyle: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
  },
  memberViewStyle: {
    flexDirection: 'row',    
  }
})