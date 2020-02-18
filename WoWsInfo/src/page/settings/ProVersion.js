import React, { Component } from 'react';
import { View, StyleSheet, ScrollView, Alert, Platform } from 'react-native';
import { WoWsInfo, LoadingIndicator } from '../../component';
import { Title, List, Button, Text, Colors } from 'react-native-paper';
import { initConnection, getSubscriptions, requestSubscription, getAvailablePurchases, finishTransaction, purchaseUpdatedListener, purchaseErrorListener } from 'react-native-iap';
import { LOCAL, setProVersion, validateProVersion } from '../../value/data';
import { Actions } from 'react-native-router-flux';

class ProVersion extends Component {
  purchaseUpdateSubscription = null
  purchaseErrorSubscription = null

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
    /// Setup listeners
    this.purchaseUpdateSubscription = purchaseUpdatedListener(async (purchase) => {
      console.log('purchaseUpdatedListener', purchase);
      const receipt = purchase.transactionReceipt;
      if (receipt) {
        // It wes successful
        await finishTransaction(purchase, false);
        
        setProVersion(true);
        // Go back automatically
        setTimeout(() => {
          Actions.pop();
          Alert.alert('WoWs Info Pro', 'Thank you for your support!');
        }, 1000);
      }
    });

    this.purchaseErrorSubscription = purchaseErrorListener((error) => {
      console.warn('purchaseErrorListener', error);
    });

    // Init connection
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

  componentWillUnmount() {
    if (this.purchaseUpdateSubscription) {
      this.purchaseUpdateSubscription.remove();
      this.purchaseUpdateSubscription = null;
    }
    if (this.purchaseErrorSubscription) {
      this.purchaseErrorSubscription.remove();
      this.purchaseErrorSubscription = null;
    }
  }
  
  render() {
    const { titleStyle, viewStyle } = styles;
    return (
      <WoWsInfo hideAds>
        <ScrollView style={viewStyle}>
          <Title style={titleStyle}>WoWs Info Pro</Title>
          <List.Item title='RS Beta' description='Get realtime statistics in your battles' />
          <List.Item title='More detailed statistics' description='Show even more statistics in your profile' />
          <List.Item title='Quick access to main account' description='Check statistics for your main account just a tap' />
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
      await requestSubscription(this.sku, false);
    } catch (err) {
      console.warn(err.code, err.message);
    }
  }

  /**
   * Get all purchases history and check for the last one
   */
  restore = async () => {
    await validateProVersion(true);
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
