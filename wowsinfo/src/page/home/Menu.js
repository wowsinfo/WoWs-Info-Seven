/**
 * Menu.js
 *
 * Menu shows wiki and extra
 * It also has the ability to search players and clans
 */

import React, {Component} from 'react';
import {
  Alert,
  ScrollView,
  StyleSheet,
  Linking,
  View,
  Share,
} from 'react-native';
import {isAndroid, isIos} from 'react-native-device-detection';
import {List, Colors, FAB, Button} from 'react-native-paper';
import * as Animatable from 'react-native-animatable';
import {WoWsInfo, SectionTitle, AppName} from '../../component';
import {lang} from '../../value/lang';
import {SafeAction, Downloader, bestWidth} from '../../core';
import {ThemeBackColour, TintColour} from '../../value/colour';
import {
  getCurrDomain,
  getCurrServer,
  getCurrPrefix,
  LOCAL,
  getFirstLaunch,
  setFirstLaunch,
  setLastLocation,
  SAVED,
  isProVersion,
  onlyProVersion,
  validateProVersion,
  setProVersion,
  differentMonth,
  APP,
} from '../../value/data';
import {Loading} from '../common/Loading';
import {Actions} from 'react-native-router-flux';
import {NativeManager} from '../../core/native/NativeManager';
import {QuickAction} from '../../core/native/QuickAction';

class Menu extends Component {
  constructor(props) {
    super(props);

    // let unitID = 'ca-app-pub-5048098651344514/1247820419';
    // if (isAndroid) unitID = 'ca-app-pub-5048098651344514/3013393881';
    // AdMobInterstitial.setAdUnitID(unitID);
    // AdMobInterstitial.setTestDevices([AdMobInterstitial.simulatorId]);

    this.first = getFirstLaunch();
    this.state = {
      loading: true,
      main: DATA[LOCAL.userInfo],
      bestItemWidth: bestWidth(400),
    };

    this.getData();
  }

  componentDidUpdate() {
    this.getData();
    const {main} = this.state;
    let curr = DATA[LOCAL.userInfo];
    setLastLocation('');
    if (curr.account_id !== main.account_id) {
      this.setState({main: curr});
    }
  }

  componentDidMount() {
    NativeManager.appHasLoaded();
    QuickAction.performPendingShortcut();

    if (this.first) {
      const time = new Promise((r, _) => setTimeout(() => r(false), 20000));

      // Update data here if it is not first launch
      let dn = new Downloader(getCurrServer());
      const update = new Promise(async (r, _) => {
        const data = await dn.updateAll(true);
        r(data);
      });

      Promise.race([time, update])
        .then(obj => {
          if (!obj) {
            Alert.alert(lang.error_title, lang.error_timeout);
            this.setState({loading: false});
          } else {
            // Make sure it finishes downloading
            if (obj.status) {
              this.setState({loading: false});
              setFirstLaunch(false);
            } else {
              // Reset to a special page
              // For now, just an error message
              Alert.alert(
                lang.error_title,
                lang.error_download_issue + '\n\n' + obj.log,
                [
                  {
                    text: lang.settings_app_send_feedback_subtitle,
                    onPress: () =>
                      Linking.openURL(APP.Developer + `&body=${obj.log}`),
                    style: 'default',
                  },
                  {
                    text: 'OK',
                    onPress: () => {},
                  },
                ],
              );
              this.setState({loading: false});
            }
          }
        })
        .catch(err => {
          console.error(err);
          this.setState({loading: false});
        });
    } else {
      if (differentMonth()) {
        this.setState({loading: false});
      } else {
        // Valid pro version once a month
        validateProVersion()
          .then(() => {
            this.setState({loading: false});
          })
          .catch();
      }
    }
  }

  getData() {
    // Data for the list
    this.wiki = [
      {
        t: lang.wiki_achievement,
        i: require('../../img/Achievement.png'),
        p: () => SafeAction('Achievement'),
      },
      {
        t: lang.wiki_warships,
        i: require('../../img/Warship.png'),
        p: () => SafeAction('Warship'),
      },
      {
        t: lang.wiki_upgrades,
        i: require('../../img/Upgrade.png'),
        p: () => SafeAction('Consumable', {upgrade: true}),
      },
      {
        t: lang.wiki_flags,
        i: require('../../img/Camouflage.png'),
        p: () => SafeAction('Consumable'),
      },
      {
        t: lang.wiki_skills,
        i: require('../../img/CommanderSkill.png'),
        p: () => SafeAction('CommanderSkill'),
      },
      {t: lang.wiki_maps, i: 'map', p: () => SafeAction('Map')},
      {
        t: lang.wiki_collections,
        i: require('../../img/Collection.png'),
        p: () => SafeAction('Collection'),
      },
    ];

    const domain = getCurrDomain();
    this.prefix = getCurrPrefix();

    this.offical_websites = [
      {t: lang.website_official_site, d: `https://worldofwarships.${domain}/`},
      {
        t: lang.website_premium,
        d: `https://${this.prefix}.wargaming.net/shop/wows/`,
      },
      {
        t: lang.website_global_wiki,
        d: `http://wiki.wargaming.net/en/World_of_Warships/`,
      },
      {t: lang.website_dev_blog, d: `https://www.facebook.com/wowsdevblog/`},
    ];

    this.stats_info_website = [
      {t: lang.website_sea_group, d: `https://sea-group.org/`},
      {
        t: lang.website_daily_bounce,
        d: `https://thedailybounce.net/category/world-of-warships/`,
      },
      {t: lang.website_numbers, d: `https://${this.prefix}.wows-numbers.com/`},
      {
        t: lang.website_models,
        d: `https://sketchfab.com/tags/world-of-warships`,
      },
      {
        t: lang.website_game_models,
        d: 'https://gamemodels3d.com/games/worldofwarships/',
      },
    ];

    this.ultility_websites = [
      {
        t: lang.website_ap_calculator,
        d: 'https://mustanghx.github.io/ship_ap_calculator/',
      },
      {t: lang.website_wowsft, d: 'https://wowsft.com/'},
    ];

    this.ingame_websites = [
      {
        t: lang.website_wargming_login,
        d: `https://${this.prefix}.wargaming.net/id/signin/`,
      },
      {
        t: lang.website_userbonus,
        d: `https://worldofwarships.${domain}/userbonus/`,
      },
      {
        t: lang.website_news_ingame,
        d: `https://worldofwarships.${domain}/news_ingame/`,
      },
      {
        t: lang.website_ingame_armory,
        d: `https://armory.worldofwarships.${domain}/`,
      },
      {
        t: lang.website_ingame_clan,
        d: `https://clans.worldofwarships.${domain}/clans/gateway/wows/profile/`,
      },
      {
        t: lang.website_ingame_warehouse,
        d: `https://warehouse.worldofwarships.${domain}/`,
      },
      {
        t: lang.website_my_logbook,
        d: `https://logbook.worldofwarships.${domain}/`,
      },
    ];

    this.youtubers = [
      {
        t: lang.youtuber_official,
        d: 'https://www.youtube.com/user/worldofwarshipsCOM',
      },
      {t: lang.youtuber_flambass, d: 'https://www.youtube.com/user/Flambass'},
      {t: lang.youtuber_flamu, d: 'https://www.youtube.com/user/cheesec4t'},
      {
        t: lang.youtuber_iChaseGaming,
        d: 'https://www.youtube.com/user/ichasegaming',
      },
      {
        t: lang.youtuber_jingles,
        d: 'https://www.youtube.com/user/BohemianEagle',
      },
      {t: lang.youtuber_notser, d: 'https://www.youtube.com/user/MrNotser'},
      {
        t: lang.youtuber_NoZoupForYou,
        d: 'https://www.youtube.com/user/ZoupGaming',
      },
      {
        t: lang.youtuber_panzerknacker,
        d: 'https://www.youtube.com/user/pzkpasch',
      },
      {
        t: lang.youtuber_Toptier,
        d: 'https://www.youtube.com/channel/UCXOZ2gv_ZGomWNcQU8BBfdQ',
      },
      {t: lang.youtuber_yuro, d: 'https://www.youtube.com/user/spzjess'},
    ];
  }

  updateBestWidth = event => {
    const goodWidth = event.nativeEvent.layout.width;
    this.setState({bestItemWidth: bestWidth(400, goodWidth)});
  };

  render() {
    const {loading, main} = this.state;
    if (loading) return <Loading />;

    // For main account
    let enabled = main.account_id !== '';
    let title = `- ${main.nickname} -`;
    if (title === '-  -') title = '- ??? -';

    return (
      <WoWsInfo
        noRight
        title={title}
        onPress={enabled ? () => SafeAction('Statistics', {info: main}) : null}
        home
        upper={false}>
        <ScrollView
          showsVerticalScrollIndicator={false}
          keyboardShouldPersistTaps="always"
          onLayout={this.updateBestWidth}>
          <Animatable.View ref="AppName" animation="fadeInDown" easing="ease">
            <AppName />
          </Animatable.View>
          {this.renderProButton()}
          <Animatable.View animation="fadeInUp" delay={200} easing="ease">
            {this.renderContent()}
          </Animatable.View>
        </ScrollView>
        <FAB
          icon="magnify"
          style={styles.fab}
          onPress={() => SafeAction('Search')}
        />
      </WoWsInfo>
    );
  }

  renderProButton() {
    if (isProVersion()) return null;
    return (
      <>
        <Button
          mode="contained"
          theme={{roundness: 0}}
          style={{marginTop: 8}}
          onPress={() => Actions.ProVersion()}>
          {lang.pro_upgrade_button}
        </Button>
      </>
    );
  }

  renderContent() {
    const {icon, wrap} = styles;
    const {bestItemWidth} = this.state;
    const store = isAndroid ? APP.GooglePlay : APP.AppStore;
    return (
      <View style={{marginBottom: 80}}>
        <SectionTitle title={lang.wiki_section_title} />
        <View style={wrap}>
          {this.wiki.map(item => (
            <List.Item
              title={item.t}
              style={{padding: 0, paddingLeft: 8, width: bestItemWidth}}
              onPress={() => item.p()}
              left={() => (
                <List.Icon
                  style={[icon, ThemeBackColour()]}
                  color={TintColour()[300]}
                  icon={item.i}
                />
              )}
              right={() =>
                isAndroid ? null : (
                  <List.Icon color={Colors.grey500} icon="chevron-right" />
                )
              }
            />
          ))}
        </View>
        <SectionTitle title={lang.extra_section_title} />
        <View style={wrap}>
          <List.Item
            title={lang.extra_wowsinfo_re}
            description={lang.extra_wowsinfo_re_subtitle}
            style={{width: bestItemWidth}}
            titleStyle={{color: Colors.orange500}}
            onPress={() => Linking.openURL('https://wowsinfo.firebaseapp.com/')}
          />
          <List.Item
            title="RS Beta"
            description={lang.extra_rs_beta}
            style={{width: bestItemWidth}}
            titleStyle={{color: Colors.orange500}}
            onPress={() => (onlyProVersion() ? SafeAction('RS') : null)}
          />
          <List.Item
            title={lang.settings_app_write_review}
            style={{width: bestItemWidth}}
            onPress={() => {
              // Add an alert to prevent
              Alert.alert(
                lang.settings_app_write_review_title,
                lang.settings_app_write_review_message,
                [
                  {
                    text: lang.settings_app_write_review_yes,
                    onPress: () => Linking.openURL(APP.Developer),
                    style: 'default',
                  },
                  {
                    text: lang.settings_app_write_review_no,
                    onPress: () => Linking.openURL(store),
                  },
                ],
                {cancelable: false},
              );
            }}
            description={store}
          />
          <List.Item
            title={lang.settings_app_share}
            onPress={() => this.shareApp(store)}
            style={{width: bestItemWidth}}
            description={lang.settings_app_share_subtitle}
          />
        </View>
        <SectionTitle title={lang.website_title} />
        <List.Accordion title={lang.website_official_title}>
          <View style={wrap}>
            {this.offical_websites.map(item => (
              <List.Item
                title={item.t}
                description={item.d}
                style={{width: bestItemWidth}}
                onPress={() => Linking.openURL(item.d)}
              />
            ))}
          </View>
        </List.Accordion>
        <List.Accordion title={lang.website_stats_news_title}>
          <View style={wrap}>
            {this.stats_info_website.map(item => (
              <List.Item
                title={item.t}
                description={item.d}
                style={{width: bestItemWidth}}
                onPress={() => Linking.openURL(item.d)}
              />
            ))}
          </View>
        </List.Accordion>
        <List.Accordion title={lang.website_utility_title}>
          <View style={wrap}>
            {this.ultility_websites.map(item => (
              <List.Item
                title={item.t}
                description={item.d}
                style={{width: bestItemWidth}}
                onPress={() => Linking.openURL(item.d)}
              />
            ))}
          </View>
        </List.Accordion>
        <List.Accordion title={lang.youtuber_title}>
          <View style={wrap}>
            {this.youtubers.map(item => (
              <List.Item
                title={item.t}
                description={item.d}
                style={{width: bestItemWidth}}
                onPress={() => Linking.openURL(item.d)}
              />
            ))}
          </View>
        </List.Accordion>
        <List.Accordion
          title={lang.website_ingame_title}
          description={lang.website_wargming_login_subtitle}>
          <View style={wrap}>
            {this.ingame_websites.map(item => (
              <List.Item
                title={item.t}
                description={item.d}
                style={{width: bestItemWidth}}
                onPress={() => Linking.openURL(item.d)}
              />
            ))}
          </View>
        </List.Accordion>
        {/* <List.Section title={lang.tool_title}>
        </List.Section> */}
      </View>
    );
  }

  shareApp = store => {
    if (isIos) {
      Share.share({url: store});
    } else {
      Share.share({message: `${lang.app_name}\n${store}`});
    }
  };
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  icon: {
    borderRadius: 100,
  },
  fab: {
    position: 'absolute',
    margin: 16,
    right: 0,
    bottom: 0,
  },
  wrap: {
    flexWrap: 'wrap',
    flexDirection: 'row',
  },
});

export {Menu};
