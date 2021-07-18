import React, {Component} from 'react';
import {View, StyleSheet, ScrollView, Alert, Linking} from 'react-native';
import {WoWsInfo, LoadingIndicator} from '../../component';
import {Title, List, Button, Text, Colors} from 'react-native-paper';
import {
  initConnection,
  getSubscriptions,
  requestSubscription,
  getAvailablePurchases,
  finishTransaction,
  purchaseUpdatedListener,
  purchaseErrorListener,
} from 'react-native-iap';
import {LOCAL, setProVersion, validateProVersion} from '../../value/data';
import {Actions} from 'react-native-router-flux';
import {lang} from '../../value/lang';

class ProVersion extends Component {
  purchaseUpdateSubscription = null;
  purchaseErrorSubscription = null;

  sku = 'wowsinfo.proversion';

  constructor(props) {
    super(props);
    this.state = {
      loading: true,
      error: false,
      price: '',
      discountPrice: '',
    };
  }

  async componentDidMount() {
    /// Setup listeners
    this.purchaseUpdateSubscription = purchaseUpdatedListener(
      async purchase => {
        console.log('purchaseUpdatedListener', purchase);
        const receipt = purchase.transactionReceipt;
        if (receipt) {
          // It wes successful
          await finishTransaction(purchase, false);

          setProVersion(true);
          // Go back automatically
          Actions.pop();
          Alert.alert(lang.pro_title, lang.iap_thx_for_support);
          setTimeout(() => {
            Actions.refresh();
          }, 500);
        }
      },
    );

    this.purchaseErrorSubscription = purchaseErrorListener(error => {
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
    const {titleStyle, viewStyle} = styles;
    return (
      <WoWsInfo hideAds>
        <ScrollView style={viewStyle}>
          <Title style={titleStyle}>{lang.pro_title}</Title>
          <List.Item title={lang.pro_rs} description={lang.pro_rs_subtite} />
          <List.Item
            title={lang.pro_more_stats}
            description={lang.pro_more_stats_subtitle}
          />
          <List.Item
            title={lang.pro_support_development}
            description={lang.pro_support_development_subtitle}
          />
        </ScrollView>
        {this.renderPurchaseView()}
        {this.renderPolicies()}
      </WoWsInfo>
    );
  }

  renderPolicies() {
    const {horizontal} = styles;
    return (
      <View style={horizontal}>
        <Button
          onPress={() =>
            Linking.openURL(
              'https://github.com/HenryQuan/WoWs-Info-Future/blob/legacy_version/Privacy%20Policy.md',
            )
          }>
          Privacy policy
        </Button>
        <Button
          onPress={() =>
            Linking.openURL(
              'https://github.com/HenryQuan/WoWs-Info-Future/blob/legacy_version/Term%20of%20Use.md',
            )
          }>
          Term of use
        </Button>
      </View>
    );
  }

  renderPurchaseView() {
    const {loading, error, price} = this.state;
    const {buttonView, restoreButton, discount, loader} = styles;
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
          <Text style={discount}>{lang.pro_50_off_until_re}</Text>
          <Button
            mode="contained"
            theme={{roundness: 0}}
            onPress={this.buy}>{`${price} / ${lang.pro_per_year}`}</Button>
          <Button
            mode="outlined"
            style={restoreButton}
            theme={{roundness: 0}}
            onPress={this.restore}>
            {lang.pro_restore_pro}
          </Button>
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
  };

  /**
   * Get all purchases history and check for the last one
   */
  restore = async () => {
    await validateProVersion(true);
  };
}

const styles = StyleSheet.create({
  viewStyle: {
    flex: 1,
  },
  horizontal: {
    flexDirection: 'row',
    justifyContent: 'center',
  },
  titleStyle: {
    padding: 16,
    paddingTop: 32,
    fontSize: 32,
    fontWeight: 'bold',
    color: Colors.orange500,
  },
  buttonView: {
    padding: 16,
  },
  restoreButton: {
    marginTop: 8,
  },
  discount: {
    textAlign: 'center',
    marginBottom: 4,
  },
  loader: {
    justifyContent: 'center',
    alignItems: 'center',
    padding: 16,
  },
});

export {ProVersion};
