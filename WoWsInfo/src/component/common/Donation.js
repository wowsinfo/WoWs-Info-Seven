import React, { Component } from 'react';
import * as RNIap from 'react-native-iap';
import { View, Platform, FlatList, StyleSheet } from 'react-native';
import { LoadingIndicator } from './LoadingIndicator';
import { Button } from 'react-native-paper';

// Now, we have 4 tiers ($1, $3, $5 and $10) for donations
const itemSkus = Platform.select({
  ios: [
    'point_1000',
  ],
  android: [
    'com.yihengquan.wowsinfo.support1',
    'com.yihengquan.wowsinfo.support3',
    'com.yihengquan.wowsinfo.support5',
    'com.yihengquan.wowsinfo.support10',
  ],
});

class Donation extends Component {
  constructor(props) {
    super(props);
    this.state = {
      products: null
    }
  }

  async componentDidMount() {
    try {
      const products = await RNIap.getProducts(itemSkus);
      products.sort((a, b) => a.price.localeCompare(b.price));
      this.setState({products});
    } catch(err) {
      console.warn(err); // standardized err.code and err.message available
    }
  }

  render() {
    const { container } = styles;
    const { products } = this.state;
    if (products == null) return <LoadingIndicator />;
    console.log(this.state);
    return (
      <View style={container}>
        <FlatList horizontal data={products} renderItem={({item}) => 
          <Button onPress={() => this.supportWoWsInfo(item)}>{item.localizedPrice}</Button>}/>
      </View>
    )
  };

  async supportWoWsInfo(item) {
    try {
      // Will return a purchase object with a receipt which can be used to validate on your server.
      const purchase = await RNIap.buyProduct(item.productId);
      // Consume it right away to buy multiple times
      await RNIap.consumePurchase(purchase.purchaseToken);
      this.setState({
        receipt: purchase.transactionReceipt, // save the receipt if you need it, whether locally, or to your server.
      });
    } catch(err) {
      // standardized err.code and err.message available
      console.error(err.code, err.message);
      const subscription = RNIap.addAdditionalSuccessPurchaseListenerIOS(async (purchase) => {
        this.setState({ receipt: purchase.transactionReceipt }, () => this.goToNext());
        subscription.remove();
      });
    }
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  }
});

export { Donation };
