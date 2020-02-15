import React, { Component } from 'react';
import { View, StyleSheet, ScrollView, Alert, Platform } from 'react-native';
import { WoWsInfo, LoadingIndicator } from '../../component';
import { Title, List, Button, Text, Colors } from 'react-native-paper';
import { initConnection, getSubscriptions, requestSubscription, getAvailablePurchases, finishTransaction } from 'react-native-iap';
import { LOCAL, setProVersion } from '../../value/data';

class ProVersion extends Component {
  sku = 'wowsinfo.proversion';

  constructor(props) {
    super(props);
    this.state = {
      loading: true,
      error: false,
      price: '',
      discountPrice: ''
    }
  }

  async componentDidMount() {
    const allgood = await initConnection();
    console.log(allgood);
    this.setState({
      error: !allgood,
    });
    
    if (allgood) {
      console.info('This device can make purchases');
      const items = await getSubscriptions([this.sku]);
      console.log(items);
      if (items.length === 1) {
        // There should only be one item which is wows info pro
        const pro = items[0];
        this.setState({
          price: pro.localizedPrice,
          discountPrice: pro.introductoryPrice,
          loading: false,
        });
      }
    }
  }
  
  render() {
    const { titleStyle, viewStyle } = styles;
    return (
      <WoWsInfo hideAds>
        <Title style={titleStyle}>WoWs Info Pro</Title>
        <ScrollView style={viewStyle}>
          <List.Item title='RS Beta' description='Get realtime statistics in your battles' />
          <List.Item title='More Statistics' description='Show even more statistics in your profile' />
          <List.Item title='Support development' description='More features are currently under development' />
        </ScrollView>
        { this.renderPurchaseView() }
      </WoWsInfo>
    )
  };

  renderPurchaseView() {
    const { loading, error, price } = this.state;
    const { buttonView, restoreButton, discount, loader } = styles;
    if (loading) {
      return (
        <View style={loader}>
          <LoadingIndicator />
        </View>
      );
    } else if (error) {
      return null;
    } else {
      return (
        <View style={buttonView}>
          <Text style={discount}>50% off for everyone until the next major update</Text>
          <Button mode='contained' theme={{roundness: 0}} onPress={this.buy}>{`${price} / Year`}</Button>
          <Button style={restoreButton} theme={{roundness: 0}} onPress={this.restore}>Restore Pro Version</Button>
        </View>
      );
    }
  }

  /**
   * Subscribe to pro version
   */
  buy = async () => {
    try {
      const result = await requestSubscription(this.sku, false);
      console.log(result);

      // Complete purchase
      await finishTransaction(result, false);
      setProVersion(true);
      Alert.alert('WoWs Info Pro', 'Thank you for your support!');
    } catch (err) {
      Alert.alert('Purchase Failed', err.message);
    }
  }

  /**
   * Get all purchases history and check for the last one
   */
  restore = async () => {
    try {
      const history = await getAvailablePurchases();
      if (history.length > 0) {
        // Sort by date first
        let latest = history.sort((a, b) => a.transactionDate - b.transactionDate)[history.length - 1];
        console.log(latest);

        if (Platform.OS === 'android') {
          // Only for Android now
          if (latest.autoRenewingAndroid === true) {
            // Set it to true
            setProVersion(true);
            Alert.alert('WoWs Info Pro', 'Thank you for your support!');
          }
        }
        
        return;
      }

      throw new Error('No payment history has been found');
    } catch (err) {
      Alert.alert('Failed to restore', err.message);
    }
  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1
  },
  titleStyle: {
    padding: 16,
    paddingTop: 32,
    fontSize: 32,
    fontWeight: 'bold',
    color: Colors.orange500
  },
  buttonView: {
    padding: 16
  },
  restoreButton: {
    marginTop: 8
  },
  discount: {
    textAlign: 'center',
    marginBottom: 4
  },
  loader: {
    justifyContent: 'center',
    alignItems: 'center',
    padding: 16
  }
})

export { ProVersion };
