import React, { Component } from 'react';
import { View, StyleSheet, ScrollView, Alert } from 'react-native';
import { WoWsInfo, LoadingIndicator } from '../../component';
import { Title, List, Button, Caption, Text } from 'react-native-paper';
import { initConnection, getSubscriptions, requestSubscription, purchaseUpdatedListener, finishTransaction, consumeAllItemsAndroid, purchaseErrorListener, getProducts, getAvailablePurchases } from 'react-native-iap';


let updateListener;
let errorListener;

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

    updateListener = purchaseUpdatedListener(async (purchase) => {
      const receipt = purchase.transactionReceipt;
      if (receipt) {
        try {
          const ackResult = await finishTransaction(purchase);
          console.log(ackResult);
        } catch (ackErr) {
          console.warn('ackErr', ackErr);
        }
      }}
    );

    errorListener = purchaseErrorListener(error => {
      console.log('purchaseErrorListener', error);
      Alert.alert('purchase error', JSON.stringify(error));
    });
  }
  
  render() {
    const { featureTitle, titleStyle, viewStyle } = styles;
    return (
      <WoWsInfo hideAds>
        <Title style={titleStyle}>WoWs Info Pro</Title>
        <ScrollView style={viewStyle}>
          <List.Section title='Features' style={featureTitle}>
            <List.Item title='RS Beta' description='Get realtime statistics in your battles' />
            <List.Item title='More Statisctis' description='Show even more statistics in your profile' />
            <List.Item title='More coming soon' description='More features are under development and will be added' />
          </List.Section>
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

  buy = () => {
    try {
      requestSubscription(this.sku, false);
    } catch (err) {
      Alert.alert(err.message);
    }
  }

  restore = () => {

  }
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1
  },
  featureTitle: {
    marginTop: -8
  },
  titleStyle: {
    padding: 16,
    fontSize: 28,
    fontWeight: 'bold',
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
