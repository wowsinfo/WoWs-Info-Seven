import React from "react";
import { AppRegistry, StyleSheet, Text, View } from "react-native";

const WoWsInfo = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.highScoresTitle}>WoWs Info</Text>
      <Text style={styles.scores}>Comming from React Native</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    backgroundColor: "#FFFFFF",
  },
  highScoresTitle: {
    fontSize: 20,
    textAlign: "center",
    margin: 10,
  },
  scores: {
    textAlign: "center",
    color: "#333333",
    marginBottom: 5,
  },
});

// Module name
AppRegistry.registerComponent("WoWsInfo", () => WoWsInfo);
