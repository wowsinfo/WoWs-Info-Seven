import React, {Component} from 'react';
import * as RNIap from 'react-native-iap';
import {View, FlatList, Linking, Platform} from 'react-native';
import {Button, List} from 'react-native-paper';
import {lang} from '../../value/lang';
import {APP} from '../../value/data';

// Now, we have 4 tiers ($1, $3, $5 and $10) for donations
const itemSkus = [
  'com.yihengquan.wowsinfo.support1',
  'com.yihengquan.wowsinfo.support3',
  'com.yihengquan.wowsinfo.support5',
  'com.yihengquan.wowsinfo.support10',
];

class Donation extends Component {
  constructor(props) {
    super(props);
    this.state = {
      products: null,
    };
  }

  async componentDidMount() {
    if (!GITHUB_VERSION) {
      try {
        const products = await RNIap.getProducts(itemSkus);
        // Do this just to ensure that all IAPs are available
        await RNIap.consumeAllItems();
        products.sort((a, b) => a.price.localeCompare(b.price));
        this.setState({products});
      } catch (err) {
        console.warn(err); // standardized err.code and err.message available
      }
    }
  }

  render() {
    const {products} = this.state;
    console.log(this.state);

    this.support = [
      {t: lang.support_patreon, d: APP.Patreon, c: 'orange'},
      {t: lang.support_paypal, d: APP.PayPal, c: 'blue'},
      {t: lang.support_wechat, d: APP.WeChat, c: 'green'},
    ];

    // They won't allow wechat and paypal
    if (!GITHUB_VERSION) {
      this.support = [
        {
          t: 'GitHub',
          d: 'https://github.com/HenryQuan/WoWs-Info-Origin',
          c: 'black',
        },
      ];
    }

    return (
      <View>
        {/* { GITHUB_VERSION || products == null ? null : 
          <FlatList horizontal data={products} renderItem={({item}) => 
            <Button style={{marginLeft: 4}} icon='favorite' color='red' compact
              onPress={() => this.supportWoWsInfo(item)}>{item.localizedPrice}</Button>}
          keyExtractor={p => p.price}/> 
        } */}
        {this.support.map(item => {
          return (
            <List.Item
              title={item.t}
              key={item.t}
              description={item.d}
              onPress={() => Linking.openURL(item.d)}
            />
          );
        })}
      </View>
    );
  }

  async supportWoWsInfo(item) {
    try {
      // Will return a purchase object with a receipt which can be used to validate on your server.
      const purchase = await RNIap.buyProduct(item.productId);
      // Consume it right away to buy multiple times
      await RNIap.consumePurchase(purchase.purchaseToken);
      this.setState({
        receipt: purchase.transactionReceipt, // save the receipt if you need it, whether locally, or to your server.
      });
    } catch (err) {
      // standardized err.code and err.message available
      console.error(err.code, err.message);
      const subscription = RNIap.addAdditionalSuccessPurchaseListenerIOS(
        async purchase => {
          this.setState({receipt: purchase.transactionReceipt}, () =>
            this.goToNext(),
          );
          subscription.remove();
        },
      );
    }
  }
}

export {Donation};
