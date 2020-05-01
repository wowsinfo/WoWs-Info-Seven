/// This is the `Plugin` class
class Plugin {
  Map<String, Consumable> consumable;
  Map<String, Upgrade> upgrade;
  Map<String, OldShip> oldShip;
  Map<String, ShipWiki> shipWiki;

  Plugin.fromJson(Map<String, dynamic> json) {
    this.consumable = json['consumables'];
    this.upgrade = json['upgrades'];
    this.oldShip = json['old_ships'];
    this.shipWiki = json['ship_wiki'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumables': this.consumable,
      'upgrades': this.upgrade,
      'old_ships': this.oldShip,
      'ship_wiki': this.shipWiki,
    };
  }
}

/// This is the `Consumable` class
class Consumable {
  BGold bGold;
  BJapanGold bJapanGold;
  BRUSGold bRUSGold;
  BUKGermanyGold bUKGermanyGold;
  BUSAGold bUSAGold;
  BUSSR bUSSR;
  CVCACLGold cVCACLGold;
  CTierOneGold cTierOneGold;
  DGold dGold;
  DefaultGold defaultGold;
  EventBBGold eventBBGold;
  EventCAGold eventCAGold;
  EventDDGold eventDDGold;
  Sub sub;
  bool canBuy;
  CanBuyCustom canBuyCustom;
  int costCR;
  bool freeOfCharge;
  int id;
  String index;
  String name;
  BColoradoGold bColoradoGold;
  BDeutscheGold bDeutscheGold;
  BRN bRN;
  BWarspiteGold bWarspiteGold;
  BYamatoGold bYamatoGold;
  CGold cGold;
  DFast dFast;
  EUDDHigh eUDDHigh;
  EUDDLow eUDDLow;
  GascogneGold gascogneGold;
  UKCAPREM uKCAPREM;
  UKCLPREM uKCLPREM;
  UKDDGold uKDDGold;
  UKHTBBPREM uKHTBBPREM;
  USAGascogne uSAGascogne;
  AnthonyEventGold anthonyEventGold;
  PlayTestGold playTestGold;
  SUDDGold sUDDGold;
  Stalingrad stalingrad;
  UKUPsGold uKUPsGold;
  USCruisersAtlanta uSCruisersAtlanta;
  USCruisersGold uSCruisersGold;
  USDDGold uSDDGold;
  YubariGold yubariGold;
  Fighter1 fighter1;
  Fighter2 fighter2;
  Fighter3 fighter3;
  Fighter4 fighter4;
  Musashi musashi;
  Default default;
  Lazo lazo;
  Perth perth;
  CruiserGold cruiserGold;
  DELvl10Gold dELvl10Gold;
  DELvl2Gold dELvl2Gold;
  DELvl3Gold dELvl3Gold;
  DELvl4Gold dELvl4Gold;
  DELvl5Gold dELvl5Gold;
  DELvl6Gold dELvl6Gold;
  DELvl7Gold dELvl7Gold;
  DELvl8Gold dELvl8Gold;
  DELvl9Gold dELvl9Gold;
  GrozovoiGold grozovoiGold;
  HaidaGold haidaGold;
  ITOil57 iTOil57;
  ITOil810 iTOil810;
  ITOilDD810 iTOilDD810;
  ITOilGorizia iTOilGorizia;
  ITOilIMPERO iTOilIMPERO;
  ITOilTestGold iTOilTestGold;
  Leone leone;
  Lvl10Gold lvl10Gold;
  Lvl2Gold lvl2Gold;
  Lvl3Gold lvl3Gold;
  Lvl4Gold lvl4Gold;
  Lvl5Gold lvl5Gold;
  Lvl6Gold lvl6Gold;
  Lvl7Gold lvl7Gold;
  Lvl8Gold lvl8Gold;
  Lvl8GoldKutuzov lvl8GoldKutuzov;
  Lvl9Gold lvl9Gold;
  PAZGold pAZGold;
  PanOceaniaGold panOceaniaGold;
  Test test;
  UKDD uKDD;
  UKLvl10Gold uKLvl10Gold;
  UKLvl2Gold uKLvl2Gold;
  UKLvl3Gold uKLvl3Gold;
  UKLvl4Gold uKLvl4Gold;
  UKLvl5Gold uKLvl5Gold;
  UKLvl6Gold uKLvl6Gold;
  UKLvl7Gold uKLvl7Gold;
  UKLvl8Gold uKLvl8Gold;
  UKLvl9Gold uKLvl9Gold;
  USLvl10Gold uSLvl10Gold;
  USLvl2Gold uSLvl2Gold;
  USLvl3Gold uSLvl3Gold;
  USLvl4Gold uSLvl4Gold;
  USLvl5Gold uSLvl5Gold;
  USLvl6Gold uSLvl6Gold;
  USLvl7Gold uSLvl7Gold;
  USLvl8Gold uSLvl8Gold;
  USLvl9Gold uSLvl9Gold;
  Cossack cossack;
  EUDDTurbo eUDDTurbo;
  FRAIGLEPREM fRAIGLEPREM;
  FRBBPREM fRBBPREM;
  FRCR67PREM fRCR67PREM;
  FRCR8910PREM fRCR8910PREM;
  FRCRHenriIV fRCRHenriIV;
  FRDD27PREM fRDD27PREM;
  FRDD810PREM fRDD810PREM;
  FRTerrible fRTerrible;
  GROZOVOIPREM gROZOVOIPREM;
  C47 c47;
  C810 c810;
  DeutscheC deutscheC;
  DeutscheC47 deutscheC47;
  DeutscheC810 deutscheC810;
  DukeOfYork dukeOfYork;
  LoYang loYang;
  Salem salem;
  UKDD610 uKDD610;
  JapDDPremAlt japDDPremAlt;
  JapDDPremium japDDPremium;
  JapDDPremiumTst japDDPremiumTst;
  MonaghanStylePremium monaghanStylePremium;
  PAZPremium pAZPremium;
  Black black;
  EUDD eUDD;
  Gb7BELFASTPREMIUM gb7BELFASTPREMIUM;
  PAZ10PREMIUM pAZ10PREMIUM;
  PAZ8PREMIUM pAZ8PREMIUM;
  PAZ9PREMIUM pAZ9PREMIUM;
  SalemPREMIUM salemPREMIUM;
  USSR10BB uSSR10BB;
  USSR10PREMIUM uSSR10PREMIUM;
  USSR8BB uSSR8BB;
  USSR8PREMIUM uSSR8PREMIUM;
  USSR9BB uSSR9BB;
  USSR9PREMIUM uSSR9PREMIUM;
  USSRCA810 uSSRCA810;
  USSROCHAKOV uSSROCHAKOV;
  US10CL uS10CL;
  US10PREMIUM uS10PREMIUM;
  US7ATLANTAPREMIUM uS7ATLANTAPREMIUM;
  US7INDIANAPOLISPREMIUM uS7INDIANAPOLISPREMIUM;
  US8CL uS8CL;
  US8PREMIUM uS8PREMIUM;
  US9CL uS9CL;
  US9MISSOURI uS9MISSOURI;
  US9PREMIUM uS9PREMIUM;
  FRBB fRBB;
  FRCR678Gold fRCR678Gold;
  FRCR910Gold fRCR910Gold;
  FRDDGold fRDDGold;
  String type;

  Consumable.fromJson(Map<String, dynamic> json) {
    this.bGold = json['B_Gold'];
    this.bJapanGold = json['B_Japan_Gold'];
    this.bRUSGold = json['B_RUS_Gold'];
    this.bUKGermanyGold = json['B_UK_Germany_Gold'];
    this.bUSAGold = json['B_USA_Gold'];
    this.bUSSR = json['B_USSR'];
    this.cVCACLGold = json['CV_CA_CL_Gold'];
    this.cTierOneGold = json['C_TierOne_Gold'];
    this.dGold = json['D_Gold'];
    this.defaultGold = json['Default_Gold'];
    this.eventBBGold = json['Event_BB_Gold'];
    this.eventCAGold = json['Event_CA_Gold'];
    this.eventDDGold = json['Event_DD_Gold'];
    this.sub = json['Sub'];
    this.canBuy = json['canBuy'];
    this.canBuyCustom = json['canBuyCustom'];
    this.costCR = json['costCR'];
    this.freeOfCharge = json['freeOfCharge'];
    this.id = json['id'];
    this.index = json['index'];
    this.name = json['name'];
    this.bColoradoGold = json['B_Colorado_Gold'];
    this.bDeutscheGold = json['B_Deutsche_gold'];
    this.bRN = json['B_RN'];
    this.bWarspiteGold = json['B_Warspite_Gold'];
    this.bYamatoGold = json['B_Yamato_Gold'];
    this.cGold = json['C_Gold'];
    this.dFast = json['D_Fast'];
    this.dGold = json['D_gold'];
    this.eUDDHigh = json['EU_DD_High'];
    this.eUDDLow = json['EU_DD_Low'];
    this.gascogneGold = json['Gascogne_gold'];
    this.uKCAPREM = json['UK_CA_PREM'];
    this.uKCLPREM = json['UK_CL_PREM'];
    this.uKDDGold = json['UK_DD_gold'];
    this.uKHTBBPREM = json['UK_HT_BB_PREM'];
    this.uSAGascogne = json['USA_Gascogne'];
    this.anthonyEventGold = json['Anthony_event_Gold'];
    this.playTestGold = json['Play_test_Gold'];
    this.sUDDGold = json['SU_DD_Gold'];
    this.stalingrad = json['Stalingrad'];
    this.uKUPsGold = json['UK_UPs_Gold'];
    this.uSCruisersAtlanta = json['US_Cruisers_Atlanta'];
    this.uSCruisersGold = json['US_Cruisers_Gold'];
    this.uSDDGold = json['US_DD_Gold'];
    this.yubariGold = json['Yubari_Gold'];
    this.fighter1 = json['Fighter_1'];
    this.fighter2 = json['Fighter_2'];
    this.fighter3 = json['Fighter_3'];
    this.fighter4 = json['Fighter_4'];
    this.musashi = json['Musashi'];
    this.default = json['Default'];
    this.lazo = json['Lazo'];
    this.perth = json['Perth'];
    this.cruiserGold = json['Cruiser_Gold'];
    this.dELvl10Gold = json['DE_Lvl_10_Gold'];
    this.dELvl2Gold = json['DE_Lvl_2_Gold'];
    this.dELvl3Gold = json['DE_Lvl_3_Gold'];
    this.dELvl4Gold = json['DE_Lvl_4_Gold'];
    this.dELvl5Gold = json['DE_Lvl_5_Gold'];
    this.dELvl6Gold = json['DE_Lvl_6_Gold'];
    this.dELvl7Gold = json['DE_Lvl_7_Gold'];
    this.dELvl8Gold = json['DE_Lvl_8_Gold'];
    this.dELvl9Gold = json['DE_Lvl_9_Gold'];
    this.grozovoiGold = json['Grozovoi_Gold'];
    this.haidaGold = json['Haida_Gold'];
    this.iTOil57 = json['IT_Oil_5_7'];
    this.iTOil810 = json['IT_Oil_8_10'];
    this.iTOilDD810 = json['IT_Oil_DD_8_10'];
    this.iTOilGorizia = json['IT_Oil_Gorizia'];
    this.iTOilIMPERO = json['IT_Oil_IMPERO'];
    this.iTOilTestGold = json['IT_Oil_Test_Gold'];
    this.leone = json['Leone'];
    this.lvl10Gold = json['Lvl_10_Gold'];
    this.lvl2Gold = json['Lvl_2_Gold'];
    this.lvl3Gold = json['Lvl_3_Gold'];
    this.lvl4Gold = json['Lvl_4_Gold'];
    this.lvl5Gold = json['Lvl_5_Gold'];
    this.lvl6Gold = json['Lvl_6_Gold'];
    this.lvl7Gold = json['Lvl_7_Gold'];
    this.lvl8Gold = json['Lvl_8_Gold'];
    this.lvl8GoldKutuzov = json['Lvl_8_Gold_Kutuzov'];
    this.lvl9Gold = json['Lvl_9_Gold'];
    this.pAZGold = json['PAZ_Gold'];
    this.panOceaniaGold = json['PanOceania_Gold'];
    this.test = json['Test'];
    this.uKDD = json['UK_DD'];
    this.uKLvl10Gold = json['UK_Lvl_10_Gold'];
    this.uKLvl2Gold = json['UK_Lvl_2_Gold'];
    this.uKLvl3Gold = json['UK_Lvl_3_Gold'];
    this.uKLvl4Gold = json['UK_Lvl_4_Gold'];
    this.uKLvl5Gold = json['UK_Lvl_5_Gold'];
    this.uKLvl6Gold = json['UK_Lvl_6_Gold'];
    this.uKLvl7Gold = json['UK_Lvl_7_Gold'];
    this.uKLvl8Gold = json['UK_Lvl_8_Gold'];
    this.uKLvl9Gold = json['UK_Lvl_9_Gold'];
    this.uSLvl10Gold = json['US_Lvl_10_Gold'];
    this.uSLvl2Gold = json['US_Lvl_2_Gold'];
    this.uSLvl3Gold = json['US_Lvl_3_Gold'];
    this.uSLvl4Gold = json['US_Lvl_4_Gold'];
    this.uSLvl5Gold = json['US_Lvl_5_Gold'];
    this.uSLvl6Gold = json['US_Lvl_6_Gold'];
    this.uSLvl7Gold = json['US_Lvl_7_Gold'];
    this.uSLvl8Gold = json['US_Lvl_8_Gold'];
    this.uSLvl9Gold = json['US_Lvl_9_Gold'];
    this.cossack = json['Cossack'];
    this.eUDDTurbo = json['EU_DD_Turbo'];
    this.fRAIGLEPREM = json['FR_AIGLE_PREM'];
    this.fRBBPREM = json['FR_BB_PREM'];
    this.fRCR67PREM = json['FR_CR_6_7_PREM'];
    this.fRCR8910PREM = json['FR_CR_8_9_10_PREM'];
    this.fRCRHenriIV = json['FR_CR_Henri_IV'];
    this.fRDD27PREM = json['FR_DD_2_7_PREM'];
    this.fRDD810PREM = json['FR_DD_8_10_PREM'];
    this.fRTerrible = json['FR_Terrible'];
    this.gROZOVOIPREM = json['GROZOVOI_PREM'];
    this.c47 = json['C_4_7'];
    this.c810 = json['C_8_10'];
    this.deutscheC = json['Deutsche_C'];
    this.deutscheC47 = json['Deutsche_C_4_7'];
    this.deutscheC810 = json['Deutsche_C_8_10'];
    this.dukeOfYork = json['DukeOfYork'];
    this.haidaGold = json['Haida_gold'];
    this.loYang = json['LoYang'];
    this.salem = json['Salem'];
    this.uKDD610 = json['UKDD_6_10'];
    this.japDDPremAlt = json['Jap_DD_prem_alt'];
    this.japDDPremium = json['Jap_DD_premium'];
    this.japDDPremiumTst = json['Jap_DD_premium_tst'];
    this.monaghanStylePremium = json['Monaghan_style_premium'];
    this.pAZPremium = json['PAZ_premium'];
    this.black = json['Black'];
    this.eUDD = json['EU_DD'];
    this.gb7BELFASTPREMIUM = json['Gb_7_BELFAST_PREMIUM'];
    this.pAZ10PREMIUM = json['PAZ_10_PREMIUM'];
    this.pAZ8PREMIUM = json['PAZ_8_PREMIUM'];
    this.pAZ9PREMIUM = json['PAZ_9_PREMIUM'];
    this.salemPREMIUM = json['Salem_PREMIUM'];
    this.uSSR10BB = json['USSR_10_BB'];
    this.uSSR10PREMIUM = json['USSR_10_PREMIUM'];
    this.uSSR8BB = json['USSR_8_BB'];
    this.uSSR8PREMIUM = json['USSR_8_PREMIUM'];
    this.uSSR9BB = json['USSR_9_BB'];
    this.uSSR9PREMIUM = json['USSR_9_PREMIUM'];
    this.uSSRCA810 = json['USSR_CA_8_10'];
    this.uSSROCHAKOV = json['USSR_OCHAKOV'];
    this.uS10CL = json['US_10_CL'];
    this.uS10PREMIUM = json['US_10_PREMIUM'];
    this.uS7ATLANTAPREMIUM = json['US_7_ATLANTA_PREMIUM'];
    this.uS7INDIANAPOLISPREMIUM = json['US_7_INDIANAPOLIS_PREMIUM'];
    this.uS8CL = json['US_8_CL'];
    this.uS8PREMIUM = json['US_8_PREMIUM'];
    this.uS9CL = json['US_9_CL'];
    this.uS9MISSOURI = json['US_9_MISSOURI'];
    this.uS9PREMIUM = json['US_9_PREMIUM'];
    this.defaultGold = json['Default_gold'];
    this.fRBB = json['FR_BB'];
    this.fRCR678Gold = json['FR_CR_6_7_8_Gold'];
    this.fRCR910Gold = json['FR_CR_9_10_Gold'];
    this.fRDDGold = json['FR_DD_Gold'];
    this.type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'B_Gold': this.bGold,
      'B_Japan_Gold': this.bJapanGold,
      'B_RUS_Gold': this.bRUSGold,
      'B_UK_Germany_Gold': this.bUKGermanyGold,
      'B_USA_Gold': this.bUSAGold,
      'B_USSR': this.bUSSR,
      'CV_CA_CL_Gold': this.cVCACLGold,
      'C_TierOne_Gold': this.cTierOneGold,
      'D_Gold': this.dGold,
      'Default_Gold': this.defaultGold,
      'Event_BB_Gold': this.eventBBGold,
      'Event_CA_Gold': this.eventCAGold,
      'Event_DD_Gold': this.eventDDGold,
      'Sub': this.sub,
      'canBuy': this.canBuy,
      'canBuyCustom': this.canBuyCustom,
      'costCR': this.costCR,
      'freeOfCharge': this.freeOfCharge,
      'id': this.id,
      'index': this.index,
      'name': this.name,
      'B_Colorado_Gold': this.bColoradoGold,
      'B_Deutsche_gold': this.bDeutscheGold,
      'B_RN': this.bRN,
      'B_Warspite_Gold': this.bWarspiteGold,
      'B_Yamato_Gold': this.bYamatoGold,
      'C_Gold': this.cGold,
      'D_Fast': this.dFast,
      'D_gold': this.dGold,
      'EU_DD_High': this.eUDDHigh,
      'EU_DD_Low': this.eUDDLow,
      'Gascogne_gold': this.gascogneGold,
      'UK_CA_PREM': this.uKCAPREM,
      'UK_CL_PREM': this.uKCLPREM,
      'UK_DD_gold': this.uKDDGold,
      'UK_HT_BB_PREM': this.uKHTBBPREM,
      'USA_Gascogne': this.uSAGascogne,
      'Anthony_event_Gold': this.anthonyEventGold,
      'Play_test_Gold': this.playTestGold,
      'SU_DD_Gold': this.sUDDGold,
      'Stalingrad': this.stalingrad,
      'UK_UPs_Gold': this.uKUPsGold,
      'US_Cruisers_Atlanta': this.uSCruisersAtlanta,
      'US_Cruisers_Gold': this.uSCruisersGold,
      'US_DD_Gold': this.uSDDGold,
      'Yubari_Gold': this.yubariGold,
      'Fighter_1': this.fighter1,
      'Fighter_2': this.fighter2,
      'Fighter_3': this.fighter3,
      'Fighter_4': this.fighter4,
      'Musashi': this.musashi,
      'Default': this.default,
      'Lazo': this.lazo,
      'Perth': this.perth,
      'Cruiser_Gold': this.cruiserGold,
      'DE_Lvl_10_Gold': this.dELvl10Gold,
      'DE_Lvl_2_Gold': this.dELvl2Gold,
      'DE_Lvl_3_Gold': this.dELvl3Gold,
      'DE_Lvl_4_Gold': this.dELvl4Gold,
      'DE_Lvl_5_Gold': this.dELvl5Gold,
      'DE_Lvl_6_Gold': this.dELvl6Gold,
      'DE_Lvl_7_Gold': this.dELvl7Gold,
      'DE_Lvl_8_Gold': this.dELvl8Gold,
      'DE_Lvl_9_Gold': this.dELvl9Gold,
      'Grozovoi_Gold': this.grozovoiGold,
      'Haida_Gold': this.haidaGold,
      'IT_Oil_5_7': this.iTOil57,
      'IT_Oil_8_10': this.iTOil810,
      'IT_Oil_DD_8_10': this.iTOilDD810,
      'IT_Oil_Gorizia': this.iTOilGorizia,
      'IT_Oil_IMPERO': this.iTOilIMPERO,
      'IT_Oil_Test_Gold': this.iTOilTestGold,
      'Leone': this.leone,
      'Lvl_10_Gold': this.lvl10Gold,
      'Lvl_2_Gold': this.lvl2Gold,
      'Lvl_3_Gold': this.lvl3Gold,
      'Lvl_4_Gold': this.lvl4Gold,
      'Lvl_5_Gold': this.lvl5Gold,
      'Lvl_6_Gold': this.lvl6Gold,
      'Lvl_7_Gold': this.lvl7Gold,
      'Lvl_8_Gold': this.lvl8Gold,
      'Lvl_8_Gold_Kutuzov': this.lvl8GoldKutuzov,
      'Lvl_9_Gold': this.lvl9Gold,
      'PAZ_Gold': this.pAZGold,
      'PanOceania_Gold': this.panOceaniaGold,
      'Test': this.test,
      'UK_DD': this.uKDD,
      'UK_Lvl_10_Gold': this.uKLvl10Gold,
      'UK_Lvl_2_Gold': this.uKLvl2Gold,
      'UK_Lvl_3_Gold': this.uKLvl3Gold,
      'UK_Lvl_4_Gold': this.uKLvl4Gold,
      'UK_Lvl_5_Gold': this.uKLvl5Gold,
      'UK_Lvl_6_Gold': this.uKLvl6Gold,
      'UK_Lvl_7_Gold': this.uKLvl7Gold,
      'UK_Lvl_8_Gold': this.uKLvl8Gold,
      'UK_Lvl_9_Gold': this.uKLvl9Gold,
      'US_Lvl_10_Gold': this.uSLvl10Gold,
      'US_Lvl_2_Gold': this.uSLvl2Gold,
      'US_Lvl_3_Gold': this.uSLvl3Gold,
      'US_Lvl_4_Gold': this.uSLvl4Gold,
      'US_Lvl_5_Gold': this.uSLvl5Gold,
      'US_Lvl_6_Gold': this.uSLvl6Gold,
      'US_Lvl_7_Gold': this.uSLvl7Gold,
      'US_Lvl_8_Gold': this.uSLvl8Gold,
      'US_Lvl_9_Gold': this.uSLvl9Gold,
      'Cossack': this.cossack,
      'EU_DD_Turbo': this.eUDDTurbo,
      'FR_AIGLE_PREM': this.fRAIGLEPREM,
      'FR_BB_PREM': this.fRBBPREM,
      'FR_CR_6_7_PREM': this.fRCR67PREM,
      'FR_CR_8_9_10_PREM': this.fRCR8910PREM,
      'FR_CR_Henri_IV': this.fRCRHenriIV,
      'FR_DD_2_7_PREM': this.fRDD27PREM,
      'FR_DD_8_10_PREM': this.fRDD810PREM,
      'FR_Terrible': this.fRTerrible,
      'GROZOVOI_PREM': this.gROZOVOIPREM,
      'C_4_7': this.c47,
      'C_8_10': this.c810,
      'Deutsche_C': this.deutscheC,
      'Deutsche_C_4_7': this.deutscheC47,
      'Deutsche_C_8_10': this.deutscheC810,
      'DukeOfYork': this.dukeOfYork,
      'Haida_gold': this.haidaGold,
      'LoYang': this.loYang,
      'Salem': this.salem,
      'UKDD_6_10': this.uKDD610,
      'Jap_DD_prem_alt': this.japDDPremAlt,
      'Jap_DD_premium': this.japDDPremium,
      'Jap_DD_premium_tst': this.japDDPremiumTst,
      'Monaghan_style_premium': this.monaghanStylePremium,
      'PAZ_premium': this.pAZPremium,
      'Black': this.black,
      'EU_DD': this.eUDD,
      'Gb_7_BELFAST_PREMIUM': this.gb7BELFASTPREMIUM,
      'PAZ_10_PREMIUM': this.pAZ10PREMIUM,
      'PAZ_8_PREMIUM': this.pAZ8PREMIUM,
      'PAZ_9_PREMIUM': this.pAZ9PREMIUM,
      'Salem_PREMIUM': this.salemPREMIUM,
      'USSR_10_BB': this.uSSR10BB,
      'USSR_10_PREMIUM': this.uSSR10PREMIUM,
      'USSR_8_BB': this.uSSR8BB,
      'USSR_8_PREMIUM': this.uSSR8PREMIUM,
      'USSR_9_BB': this.uSSR9BB,
      'USSR_9_PREMIUM': this.uSSR9PREMIUM,
      'USSR_CA_8_10': this.uSSRCA810,
      'USSR_OCHAKOV': this.uSSROCHAKOV,
      'US_10_CL': this.uS10CL,
      'US_10_PREMIUM': this.uS10PREMIUM,
      'US_7_ATLANTA_PREMIUM': this.uS7ATLANTAPREMIUM,
      'US_7_INDIANAPOLIS_PREMIUM': this.uS7INDIANAPOLISPREMIUM,
      'US_8_CL': this.uS8CL,
      'US_8_PREMIUM': this.uS8PREMIUM,
      'US_9_CL': this.uS9CL,
      'US_9_MISSOURI': this.uS9MISSOURI,
      'US_9_PREMIUM': this.uS9PREMIUM,
      'Default_gold': this.defaultGold,
      'FR_BB': this.fRBB,
      'FR_CR_6_7_8_Gold': this.fRCR678Gold,
      'FR_CR_9_10_Gold': this.fRCR910Gold,
      'FR_DD_Gold': this.fRDDGold,
      'type': this.type,
    };
  }
}

/// This is the `BGold` class
class BGold {
  String consumableType;
  double reloadTime;
  double workTime;
  int numConsumable;
  double regenerationHPSpeed;

  BGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
    };
  }
}

/// This is the `BJapanGold` class
class BJapanGold {
  String consumableType;
  double reloadTime;
  double workTime;

  BJapanGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `BRUSGold` class
class BRUSGold {
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  BRUSGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `BUKGermanyGold` class
class BUKGermanyGold {
  String consumableType;
  double reloadTime;
  double workTime;

  BUKGermanyGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `BUSAGold` class
class BUSAGold {
  String consumableType;
  double reloadTime;
  double workTime;

  BUSAGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `BUSSR` class
class BUSSR {
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  BUSSR.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `CVCACLGold` class
class CVCACLGold {
  String consumableType;
  double reloadTime;
  double workTime;

  CVCACLGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `CTierOneGold` class
class CTierOneGold {
  String consumableType;
  double reloadTime;
  double workTime;

  CTierOneGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DGold` class
class DGold {
  String consumableType;
  double reloadTime;
  double workTime;
  int numConsumable;
  double regenerationHPSpeed;

  DGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
    };
  }
}

/// This is the `DefaultGold` class
class DefaultGold {
  String consumableType;
  double reloadTime;
  double workTime;
  double areaDamageMultiplier;
  double bubbleDamageMultiplier;
  int numConsumable;
  double boostCoeff;
  double criticalChance;

  DefaultGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];
    this.numConsumable = json['numConsumables'];
    this.boostCoeff = json['boostCoeff'];
    this.criticalChance = json['criticalChance'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'numConsumables': this.numConsumable,
      'boostCoeff': this.boostCoeff,
      'criticalChance': this.criticalChance,
    };
  }
}

/// This is the `EventBBGold` class
class EventBBGold {
  String consumableType;
  double reloadTime;
  double workTime;

  EventBBGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `EventCAGold` class
class EventCAGold {
  String consumableType;
  double reloadTime;
  double workTime;

  EventCAGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `EventDDGold` class
class EventDDGold {
  String consumableType;
  double reloadTime;
  double workTime;

  EventDDGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Sub` class
class Sub {
  String consumableType;
  double reloadTime;
  double workTime;

  Sub.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `CanBuyCustom` class
class CanBuyCustom {
  dynamic canBuyCustom;

  CanBuyCustom.fromJson(Map<String, dynamic> json) {
    this.canBuyCustom = json['canBuyCustom'];
  }

  Map<String, dynamic> toJson() {
    return {
      'canBuyCustom': this.canBuyCustom,
    };
  }
}

/// This is the `BColoradoGold` class
class BColoradoGold {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  BColoradoGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `BDeutscheGold` class
class BDeutscheGold {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  BDeutscheGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `BRN` class
class BRN {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  BRN.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `BWarspiteGold` class
class BWarspiteGold {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  BWarspiteGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `BYamatoGold` class
class BYamatoGold {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  BYamatoGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `CGold` class
class CGold {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  CGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DFast` class
class DFast {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  DFast.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `EUDDHigh` class
class EUDDHigh {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  EUDDHigh.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `EUDDLow` class
class EUDDLow {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  EUDDLow.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `GascogneGold` class
class GascogneGold {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  GascogneGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKCAPREM` class
class UKCAPREM {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  UKCAPREM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKCLPREM` class
class UKCLPREM {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;

  UKCLPREM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
    };
  }
}

/// This is the `UKDDGold` class
class UKDDGold {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  UKDDGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKHTBBPREM` class
class UKHTBBPREM {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  UKHTBBPREM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USAGascogne` class
class USAGascogne {
  String consumableType;
  int numConsumable;
  double regenerationHPSpeed;
  double reloadTime;
  double workTime;

  USAGascogne.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.regenerationHPSpeed = json['regenerationHPSpeed'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'regenerationHPSpeed': this.regenerationHPSpeed,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `AnthonyEventGold` class
class AnthonyEventGold {
  double areaDamageMultiplier;
  int bubbleDamageMultiplier;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  AnthonyEventGold.fromJson(Map<String, dynamic> json) {
    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `PlayTestGold` class
class PlayTestGold {
  double areaDamageMultiplier;
  int bubbleDamageMultiplier;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  PlayTestGold.fromJson(Map<String, dynamic> json) {
    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `SUDDGold` class
class SUDDGold {
  double areaDamageMultiplier;
  double bubbleDamageMultiplier;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  SUDDGold.fromJson(Map<String, dynamic> json) {
    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Stalingrad` class
class Stalingrad {
  double areaDamageMultiplier;
  double bubbleDamageMultiplier;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  Stalingrad.fromJson(Map<String, dynamic> json) {
    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKUPsGold` class
class UKUPsGold {
  double areaDamageMultiplier;
  double bubbleDamageMultiplier;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  UKUPsGold.fromJson(Map<String, dynamic> json) {
    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USCruisersAtlanta` class
class USCruisersAtlanta {
  double areaDamageMultiplier;
  double bubbleDamageMultiplier;
  String consumableType;
  double reloadTime;
  double workTime;

  USCruisersAtlanta.fromJson(Map<String, dynamic> json) {
    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];
    this.consumableType = json['consumableType'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'consumableType': this.consumableType,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USCruisersGold` class
class USCruisersGold {
  double areaDamageMultiplier;
  double bubbleDamageMultiplier;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  USCruisersGold.fromJson(Map<String, dynamic> json) {
    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USDDGold` class
class USDDGold {
  double areaDamageMultiplier;
  double bubbleDamageMultiplier;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  USDDGold.fromJson(Map<String, dynamic> json) {
    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `YubariGold` class
class YubariGold {
  double areaDamageMultiplier;
  double bubbleDamageMultiplier;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  YubariGold.fromJson(Map<String, dynamic> json) {
    this.areaDamageMultiplier = json['areaDamageMultiplier'];
    this.bubbleDamageMultiplier = json['bubbleDamageMultiplier'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'areaDamageMultiplier': this.areaDamageMultiplier,
      'bubbleDamageMultiplier': this.bubbleDamageMultiplier,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Fighter1` class
class Fighter1 {
  int climbAngle;
  String consumableType;
  double distanceToKill;
  double dogFightTime;
  String fightersName;
  int fightersNum;
  double flyAwayTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double timeDelayAttack;
  double timeToTryingCatch;
  double timeWaitDelayAttack;
  double workTime;

  Fighter1.fromJson(Map<String, dynamic> json) {
    this.climbAngle = json['climbAngle'];
    this.consumableType = json['consumableType'];
    this.distanceToKill = json['distanceToKill'];
    this.dogFightTime = json['dogFightTime'];
    this.fightersName = json['fightersName'];
    this.fightersNum = json['fightersNum'];
    this.flyAwayTime = json['flyAwayTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.timeDelayAttack = json['timeDelayAttack'];
    this.timeToTryingCatch = json['timeToTryingCatch'];
    this.timeWaitDelayAttack = json['timeWaitDelayAttack'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'climbAngle': this.climbAngle,
      'consumableType': this.consumableType,
      'distanceToKill': this.distanceToKill,
      'dogFightTime': this.dogFightTime,
      'fightersName': this.fightersName,
      'fightersNum': this.fightersNum,
      'flyAwayTime': this.flyAwayTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'timeDelayAttack': this.timeDelayAttack,
      'timeToTryingCatch': this.timeToTryingCatch,
      'timeWaitDelayAttack': this.timeWaitDelayAttack,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Fighter2` class
class Fighter2 {
  int climbAngle;
  String consumableType;
  double distanceToKill;
  double dogFightTime;
  String fightersName;
  int fightersNum;
  double flyAwayTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double timeDelayAttack;
  double timeToTryingCatch;
  double timeWaitDelayAttack;
  double workTime;

  Fighter2.fromJson(Map<String, dynamic> json) {
    this.climbAngle = json['climbAngle'];
    this.consumableType = json['consumableType'];
    this.distanceToKill = json['distanceToKill'];
    this.dogFightTime = json['dogFightTime'];
    this.fightersName = json['fightersName'];
    this.fightersNum = json['fightersNum'];
    this.flyAwayTime = json['flyAwayTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.timeDelayAttack = json['timeDelayAttack'];
    this.timeToTryingCatch = json['timeToTryingCatch'];
    this.timeWaitDelayAttack = json['timeWaitDelayAttack'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'climbAngle': this.climbAngle,
      'consumableType': this.consumableType,
      'distanceToKill': this.distanceToKill,
      'dogFightTime': this.dogFightTime,
      'fightersName': this.fightersName,
      'fightersNum': this.fightersNum,
      'flyAwayTime': this.flyAwayTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'timeDelayAttack': this.timeDelayAttack,
      'timeToTryingCatch': this.timeToTryingCatch,
      'timeWaitDelayAttack': this.timeWaitDelayAttack,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Fighter3` class
class Fighter3 {
  int climbAngle;
  String consumableType;
  double distanceToKill;
  double dogFightTime;
  String fightersName;
  int fightersNum;
  double flyAwayTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double timeDelayAttack;
  double timeToTryingCatch;
  double timeWaitDelayAttack;
  double workTime;

  Fighter3.fromJson(Map<String, dynamic> json) {
    this.climbAngle = json['climbAngle'];
    this.consumableType = json['consumableType'];
    this.distanceToKill = json['distanceToKill'];
    this.dogFightTime = json['dogFightTime'];
    this.fightersName = json['fightersName'];
    this.fightersNum = json['fightersNum'];
    this.flyAwayTime = json['flyAwayTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.timeDelayAttack = json['timeDelayAttack'];
    this.timeToTryingCatch = json['timeToTryingCatch'];
    this.timeWaitDelayAttack = json['timeWaitDelayAttack'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'climbAngle': this.climbAngle,
      'consumableType': this.consumableType,
      'distanceToKill': this.distanceToKill,
      'dogFightTime': this.dogFightTime,
      'fightersName': this.fightersName,
      'fightersNum': this.fightersNum,
      'flyAwayTime': this.flyAwayTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'timeDelayAttack': this.timeDelayAttack,
      'timeToTryingCatch': this.timeToTryingCatch,
      'timeWaitDelayAttack': this.timeWaitDelayAttack,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Fighter4` class
class Fighter4 {
  int climbAngle;
  String consumableType;
  double distanceToKill;
  double dogFightTime;
  String fightersName;
  int fightersNum;
  double flyAwayTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double timeDelayAttack;
  double timeToTryingCatch;
  double timeWaitDelayAttack;
  double workTime;

  Fighter4.fromJson(Map<String, dynamic> json) {
    this.climbAngle = json['climbAngle'];
    this.consumableType = json['consumableType'];
    this.distanceToKill = json['distanceToKill'];
    this.dogFightTime = json['dogFightTime'];
    this.fightersName = json['fightersName'];
    this.fightersNum = json['fightersNum'];
    this.flyAwayTime = json['flyAwayTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.timeDelayAttack = json['timeDelayAttack'];
    this.timeToTryingCatch = json['timeToTryingCatch'];
    this.timeWaitDelayAttack = json['timeWaitDelayAttack'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'climbAngle': this.climbAngle,
      'consumableType': this.consumableType,
      'distanceToKill': this.distanceToKill,
      'dogFightTime': this.dogFightTime,
      'fightersName': this.fightersName,
      'fightersNum': this.fightersNum,
      'flyAwayTime': this.flyAwayTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'timeDelayAttack': this.timeDelayAttack,
      'timeToTryingCatch': this.timeToTryingCatch,
      'timeWaitDelayAttack': this.timeWaitDelayAttack,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Musashi` class
class Musashi {
  int climbAngle;
  String consumableType;
  double distanceToKill;
  double dogFightTime;
  String fightersName;
  int fightersNum;
  double flyAwayTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double timeDelayAttack;
  double timeToTryingCatch;
  double timeWaitDelayAttack;
  double workTime;
  double artilleryDistCoeff;

  Musashi.fromJson(Map<String, dynamic> json) {
    this.climbAngle = json['climbAngle'];
    this.consumableType = json['consumableType'];
    this.distanceToKill = json['distanceToKill'];
    this.dogFightTime = json['dogFightTime'];
    this.fightersName = json['fightersName'];
    this.fightersNum = json['fightersNum'];
    this.flyAwayTime = json['flyAwayTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.timeDelayAttack = json['timeDelayAttack'];
    this.timeToTryingCatch = json['timeToTryingCatch'];
    this.timeWaitDelayAttack = json['timeWaitDelayAttack'];
    this.workTime = json['workTime'];
    this.artilleryDistCoeff = json['artilleryDistCoeff'];
  }

  Map<String, dynamic> toJson() {
    return {
      'climbAngle': this.climbAngle,
      'consumableType': this.consumableType,
      'distanceToKill': this.distanceToKill,
      'dogFightTime': this.dogFightTime,
      'fightersName': this.fightersName,
      'fightersNum': this.fightersNum,
      'flyAwayTime': this.flyAwayTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'timeDelayAttack': this.timeDelayAttack,
      'timeToTryingCatch': this.timeToTryingCatch,
      'timeWaitDelayAttack': this.timeWaitDelayAttack,
      'workTime': this.workTime,
      'artilleryDistCoeff': this.artilleryDistCoeff,
    };
  }
}

/// This is the `Default` class
class Default {
  double artilleryDistCoeff;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;
  double height;
  double lifeTime;
  double radiu;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  double distShip;
  double distTorpedo;
  double torpedoReloadTime;

  Default.fromJson(Map<String, dynamic> json) {
    this.artilleryDistCoeff = json['artilleryDistCoeff'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.radiu = json['radius'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.torpedoReloadTime = json['torpedoReloadTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'artilleryDistCoeff': this.artilleryDistCoeff,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'radius': this.radiu,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'torpedoReloadTime': this.torpedoReloadTime,
    };
  }
}

/// This is the `Lazo` class
class Lazo {
  double artilleryDistCoeff;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  Lazo.fromJson(Map<String, dynamic> json) {
    this.artilleryDistCoeff = json['artilleryDistCoeff'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'artilleryDistCoeff': this.artilleryDistCoeff,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Perth` class
class Perth {
  double artilleryDistCoeff;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  Perth.fromJson(Map<String, dynamic> json) {
    this.artilleryDistCoeff = json['artilleryDistCoeff'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'artilleryDistCoeff': this.artilleryDistCoeff,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `CruiserGold` class
class CruiserGold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  CruiserGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DELvl10Gold` class
class DELvl10Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  DELvl10Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DELvl2Gold` class
class DELvl2Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  DELvl2Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DELvl3Gold` class
class DELvl3Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  DELvl3Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DELvl4Gold` class
class DELvl4Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  DELvl4Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DELvl5Gold` class
class DELvl5Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  DELvl5Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DELvl6Gold` class
class DELvl6Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  DELvl6Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DELvl7Gold` class
class DELvl7Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  DELvl7Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DELvl8Gold` class
class DELvl8Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  DELvl8Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DELvl9Gold` class
class DELvl9Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  DELvl9Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `GrozovoiGold` class
class GrozovoiGold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  GrozovoiGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `HaidaGold` class
class HaidaGold {
  String consumableType;
  String descID;
  double height;
  String iconID;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  String titleID;
  double workTime;
  double distShip;
  double distTorpedo;

  HaidaGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.descID = json['descIDs'];
    this.height = json['height'];
    this.iconID = json['iconIDs'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.titleID = json['titleIDs'];
    this.workTime = json['workTime'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'descIDs': this.descID,
      'height': this.height,
      'iconIDs': this.iconID,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'titleIDs': this.titleID,
      'workTime': this.workTime,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
    };
  }
}

/// This is the `ITOil57` class
class ITOil57 {
  String consumableType;
  String descID;
  double height;
  String iconID;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  String titleID;
  double workTime;

  ITOil57.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.descID = json['descIDs'];
    this.height = json['height'];
    this.iconID = json['iconIDs'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.titleID = json['titleIDs'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'descIDs': this.descID,
      'height': this.height,
      'iconIDs': this.iconID,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'titleIDs': this.titleID,
      'workTime': this.workTime,
    };
  }
}

/// This is the `ITOil810` class
class ITOil810 {
  String consumableType;
  String descID;
  double height;
  String iconID;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  String titleID;
  double workTime;

  ITOil810.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.descID = json['descIDs'];
    this.height = json['height'];
    this.iconID = json['iconIDs'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.titleID = json['titleIDs'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'descIDs': this.descID,
      'height': this.height,
      'iconIDs': this.iconID,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'titleIDs': this.titleID,
      'workTime': this.workTime,
    };
  }
}

/// This is the `ITOilDD810` class
class ITOilDD810 {
  String consumableType;
  String descID;
  double height;
  String iconID;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  String titleID;
  double workTime;

  ITOilDD810.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.descID = json['descIDs'];
    this.height = json['height'];
    this.iconID = json['iconIDs'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.titleID = json['titleIDs'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'descIDs': this.descID,
      'height': this.height,
      'iconIDs': this.iconID,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'titleIDs': this.titleID,
      'workTime': this.workTime,
    };
  }
}

/// This is the `ITOilGorizia` class
class ITOilGorizia {
  String consumableType;
  String descID;
  double height;
  String iconID;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  String titleID;
  double workTime;

  ITOilGorizia.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.descID = json['descIDs'];
    this.height = json['height'];
    this.iconID = json['iconIDs'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.titleID = json['titleIDs'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'descIDs': this.descID,
      'height': this.height,
      'iconIDs': this.iconID,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'titleIDs': this.titleID,
      'workTime': this.workTime,
    };
  }
}

/// This is the `ITOilIMPERO` class
class ITOilIMPERO {
  String consumableType;
  String descID;
  double height;
  String iconID;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  String titleID;
  double workTime;

  ITOilIMPERO.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.descID = json['descIDs'];
    this.height = json['height'];
    this.iconID = json['iconIDs'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.titleID = json['titleIDs'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'descIDs': this.descID,
      'height': this.height,
      'iconIDs': this.iconID,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'titleIDs': this.titleID,
      'workTime': this.workTime,
    };
  }
}

/// This is the `ITOilTestGold` class
class ITOilTestGold {
  String consumableType;
  String descID;
  double height;
  String iconID;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  String titleID;
  double workTime;

  ITOilTestGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.descID = json['descIDs'];
    this.height = json['height'];
    this.iconID = json['iconIDs'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.titleID = json['titleIDs'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'descIDs': this.descID,
      'height': this.height,
      'iconIDs': this.iconID,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'titleIDs': this.titleID,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Leone` class
class Leone {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Leone.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Lvl10Gold` class
class Lvl10Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Lvl10Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Lvl2Gold` class
class Lvl2Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Lvl2Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Lvl3Gold` class
class Lvl3Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Lvl3Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Lvl4Gold` class
class Lvl4Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Lvl4Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Lvl5Gold` class
class Lvl5Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Lvl5Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Lvl6Gold` class
class Lvl6Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Lvl6Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Lvl7Gold` class
class Lvl7Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Lvl7Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Lvl8Gold` class
class Lvl8Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Lvl8Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Lvl8GoldKutuzov` class
class Lvl8GoldKutuzov {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Lvl8GoldKutuzov.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Lvl9Gold` class
class Lvl9Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  Lvl9Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `PAZGold` class
class PAZGold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  PAZGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `PanOceaniaGold` class
class PanOceaniaGold {
  String consumableType;
  String descID;
  double height;
  String iconID;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  String titleID;
  double workTime;

  PanOceaniaGold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.descID = json['descIDs'];
    this.height = json['height'];
    this.iconID = json['iconIDs'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.titleID = json['titleIDs'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'descIDs': this.descID,
      'height': this.height,
      'iconIDs': this.iconID,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'titleIDs': this.titleID,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Test` class
class Test {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;

  Test.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
    };
  }
}

/// This is the `UKDD` class
class UKDD {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  UKDD.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKLvl10Gold` class
class UKLvl10Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  UKLvl10Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKLvl2Gold` class
class UKLvl2Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  UKLvl2Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKLvl3Gold` class
class UKLvl3Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  UKLvl3Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKLvl4Gold` class
class UKLvl4Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  UKLvl4Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKLvl5Gold` class
class UKLvl5Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  UKLvl5Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKLvl6Gold` class
class UKLvl6Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  UKLvl6Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKLvl7Gold` class
class UKLvl7Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  UKLvl7Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKLvl8Gold` class
class UKLvl8Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  UKLvl8Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKLvl9Gold` class
class UKLvl9Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  UKLvl9Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USLvl10Gold` class
class USLvl10Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  USLvl10Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USLvl2Gold` class
class USLvl2Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  USLvl2Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USLvl3Gold` class
class USLvl3Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  USLvl3Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USLvl4Gold` class
class USLvl4Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  USLvl4Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USLvl5Gold` class
class USLvl5Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  USLvl5Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USLvl6Gold` class
class USLvl6Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  USLvl6Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USLvl7Gold` class
class USLvl7Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  USLvl7Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USLvl8Gold` class
class USLvl8Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  USLvl8Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USLvl9Gold` class
class USLvl9Gold {
  String consumableType;
  double height;
  double lifeTime;
  int numConsumable;
  double radiu;
  double reloadTime;
  double spawnBackwardShift;
  double speedLimit;
  double startDelayTime;
  double workTime;

  USLvl9Gold.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.height = json['height'];
    this.lifeTime = json['lifeTime'];
    this.numConsumable = json['numConsumables'];
    this.radiu = json['radius'];
    this.reloadTime = json['reloadTime'];
    this.spawnBackwardShift = json['spawnBackwardShift'];
    this.speedLimit = json['speedLimit'];
    this.startDelayTime = json['startDelayTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'height': this.height,
      'lifeTime': this.lifeTime,
      'numConsumables': this.numConsumable,
      'radius': this.radiu,
      'reloadTime': this.reloadTime,
      'spawnBackwardShift': this.spawnBackwardShift,
      'speedLimit': this.speedLimit,
      'startDelayTime': this.startDelayTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Cossack` class
class Cossack {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  Cossack.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `EUDDTurbo` class
class EUDDTurbo {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  EUDDTurbo.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRAIGLEPREM` class
class FRAIGLEPREM {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRAIGLEPREM.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRBBPREM` class
class FRBBPREM {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRBBPREM.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRCR67PREM` class
class FRCR67PREM {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRCR67PREM.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRCR8910PREM` class
class FRCR8910PREM {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRCR8910PREM.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRCRHenriIV` class
class FRCRHenriIV {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRCRHenriIV.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRDD27PREM` class
class FRDD27PREM {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRDD27PREM.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRDD810PREM` class
class FRDD810PREM {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRDD810PREM.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRTerrible` class
class FRTerrible {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRTerrible.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `GROZOVOIPREM` class
class GROZOVOIPREM {
  double backwardEngineForsag;
  double backwardEngineForsagMaxSpeed;
  double boostCoeff;
  String consumableType;
  double forwardEngineForsag;
  double forwardEngineForsagMaxSpeed;
  int numConsumable;
  double reloadTime;
  double workTime;

  GROZOVOIPREM.fromJson(Map<String, dynamic> json) {
    this.backwardEngineForsag = json['backwardEngineForsag'];
    this.backwardEngineForsagMaxSpeed = json['backwardEngineForsagMaxSpeed'];
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.forwardEngineForsag = json['forwardEngineForsag'];
    this.forwardEngineForsagMaxSpeed = json['forwardEngineForsagMaxSpeed'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'backwardEngineForsag': this.backwardEngineForsag,
      'backwardEngineForsagMaxSpeed': this.backwardEngineForsagMaxSpeed,
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'forwardEngineForsag': this.forwardEngineForsag,
      'forwardEngineForsagMaxSpeed': this.forwardEngineForsagMaxSpeed,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `C47` class
class C47 {
  String consumableType;
  double distShip;
  double distTorpedo;
  int numConsumable;
  double reloadTime;
  double workTime;

  C47.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `C810` class
class C810 {
  String consumableType;
  double distShip;
  double distTorpedo;
  int numConsumable;
  double reloadTime;
  double workTime;

  C810.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DeutscheC` class
class DeutscheC {
  String consumableType;
  double distShip;
  double distTorpedo;
  int numConsumable;
  double reloadTime;
  double workTime;

  DeutscheC.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DeutscheC47` class
class DeutscheC47 {
  String consumableType;
  double distShip;
  double distTorpedo;
  int numConsumable;
  double reloadTime;
  double workTime;

  DeutscheC47.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DeutscheC810` class
class DeutscheC810 {
  String consumableType;
  double distShip;
  double distTorpedo;
  int numConsumable;
  double reloadTime;
  double workTime;

  DeutscheC810.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `DukeOfYork` class
class DukeOfYork {
  String consumableType;
  double distShip;
  double distTorpedo;
  int numConsumable;
  double reloadTime;
  double workTime;

  DukeOfYork.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `LoYang` class
class LoYang {
  String consumableType;
  double distShip;
  double distTorpedo;
  int numConsumable;
  double reloadTime;
  double workTime;

  LoYang.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Salem` class
class Salem {
  String consumableType;
  double distShip;
  double distTorpedo;
  int numConsumable;
  double reloadTime;
  double workTime;

  Salem.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `UKDD610` class
class UKDD610 {
  String consumableType;
  double distShip;
  double distTorpedo;
  int numConsumable;
  double reloadTime;
  double workTime;

  UKDD610.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.distTorpedo = json['distTorpedo'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'distTorpedo': this.distTorpedo,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `JapDDPremAlt` class
class JapDDPremAlt {
  String consumableType;
  int numConsumable;
  double reloadTime;
  double torpedoReloadTime;
  double workTime;

  JapDDPremAlt.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.torpedoReloadTime = json['torpedoReloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'torpedoReloadTime': this.torpedoReloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `JapDDPremium` class
class JapDDPremium {
  String consumableType;
  int numConsumable;
  double reloadTime;
  double torpedoReloadTime;
  double workTime;

  JapDDPremium.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.torpedoReloadTime = json['torpedoReloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'torpedoReloadTime': this.torpedoReloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `JapDDPremiumTst` class
class JapDDPremiumTst {
  String consumableType;
  int numConsumable;
  double reloadTime;
  double torpedoReloadTime;
  double workTime;

  JapDDPremiumTst.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.torpedoReloadTime = json['torpedoReloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'torpedoReloadTime': this.torpedoReloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `MonaghanStylePremium` class
class MonaghanStylePremium {
  String consumableType;
  int numConsumable;
  double reloadTime;
  double torpedoReloadTime;
  double workTime;

  MonaghanStylePremium.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.torpedoReloadTime = json['torpedoReloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'torpedoReloadTime': this.torpedoReloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `PAZPremium` class
class PAZPremium {
  String consumableType;
  int numConsumable;
  double reloadTime;
  double torpedoReloadTime;
  double workTime;

  PAZPremium.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.torpedoReloadTime = json['torpedoReloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'torpedoReloadTime': this.torpedoReloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Black` class
class Black {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  Black.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `EUDD` class
class EUDD {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  EUDD.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Gb7BELFASTPREMIUM` class
class Gb7BELFASTPREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  Gb7BELFASTPREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `PAZ10PREMIUM` class
class PAZ10PREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  PAZ10PREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `PAZ8PREMIUM` class
class PAZ8PREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  PAZ8PREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `PAZ9PREMIUM` class
class PAZ9PREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  PAZ9PREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `SalemPREMIUM` class
class SalemPREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  SalemPREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USSR10BB` class
class USSR10BB {
  List<String> affectedClasse;
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  USSR10BB.fromJson(Map<String, dynamic> json) {
    this.affectedClasse = json['affectedClasses'];
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'affectedClasses': this.affectedClasse,
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USSR10PREMIUM` class
class USSR10PREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  USSR10PREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USSR8BB` class
class USSR8BB {
  List<String> affectedClasse;
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  USSR8BB.fromJson(Map<String, dynamic> json) {
    this.affectedClasse = json['affectedClasses'];
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'affectedClasses': this.affectedClasse,
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USSR8PREMIUM` class
class USSR8PREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  USSR8PREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USSR9BB` class
class USSR9BB {
  List<String> affectedClasse;
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  USSR9BB.fromJson(Map<String, dynamic> json) {
    this.affectedClasse = json['affectedClasses'];
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'affectedClasses': this.affectedClasse,
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USSR9PREMIUM` class
class USSR9PREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  USSR9PREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USSRCA810` class
class USSRCA810 {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  USSRCA810.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `USSROCHAKOV` class
class USSROCHAKOV {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  USSROCHAKOV.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `US10CL` class
class US10CL {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  US10CL.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `US10PREMIUM` class
class US10PREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  US10PREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `US7ATLANTAPREMIUM` class
class US7ATLANTAPREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  US7ATLANTAPREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `US7INDIANAPOLISPREMIUM` class
class US7INDIANAPOLISPREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  US7INDIANAPOLISPREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `US8CL` class
class US8CL {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  US8CL.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `US8PREMIUM` class
class US8PREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  US8PREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `US9CL` class
class US9CL {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  US9CL.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `US9MISSOURI` class
class US9MISSOURI {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  US9MISSOURI.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `US9PREMIUM` class
class US9PREMIUM {
  String consumableType;
  double distShip;
  int numConsumable;
  double reloadTime;
  double workTime;

  US9PREMIUM.fromJson(Map<String, dynamic> json) {
    this.consumableType = json['consumableType'];
    this.distShip = json['distShip'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'consumableType': this.consumableType,
      'distShip': this.distShip,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRBB` class
class FRBB {
  double boostCoeff;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRBB.fromJson(Map<String, dynamic> json) {
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRCR678Gold` class
class FRCR678Gold {
  double boostCoeff;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRCR678Gold.fromJson(Map<String, dynamic> json) {
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRCR910Gold` class
class FRCR910Gold {
  double boostCoeff;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRCR910Gold.fromJson(Map<String, dynamic> json) {
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `FRDDGold` class
class FRDDGold {
  double boostCoeff;
  String consumableType;
  int numConsumable;
  double reloadTime;
  double workTime;

  FRDDGold.fromJson(Map<String, dynamic> json) {
    this.boostCoeff = json['boostCoeff'];
    this.consumableType = json['consumableType'];
    this.numConsumable = json['numConsumables'];
    this.reloadTime = json['reloadTime'];
    this.workTime = json['workTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'boostCoeff': this.boostCoeff,
      'consumableType': this.consumableType,
      'numConsumables': this.numConsumable,
      'reloadTime': this.reloadTime,
      'workTime': this.workTime,
    };
  }
}

/// This is the `Upgrade` class
class Upgrade {
  int slot;
  List<int> shiplevel;
  List<String> ship;
  List<String> shiptype;
  List<String> nation;

  Upgrade.fromJson(Map<String, dynamic> json) {
    this.slot = json['slot'];
    this.shiplevel = json['shiplevel'];
    this.ship = json['ships'];
    this.shiptype = json['shiptype'];
    this.nation = json['nation'];
  }

  Map<String, dynamic> toJson() {
    return {
      'slot': this.slot,
      'shiplevel': this.shiplevel,
      'ships': this.ship,
      'shiptype': this.shiptype,
      'nation': this.nation,
    };
  }
}

/// This is the `OldShip` class
class OldShip {
  String name;
  int tier;

  OldShip.fromJson(Map<String, dynamic> json) {
    this.name = json['name'];
    this.tier = json['tier'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'tier': this.tier,
    };
  }
}

/// This is the `ShipWiki` class
class ShipWiki {
  double alphaPiercingHE;
  Ap ap;
  double sigma;
  List<Consumable> consumable;
  bool isPaperShip;
  List<int> permoflage;
  int battle;

  ShipWiki.fromJson(Map<String, dynamic> json) {
    this.alphaPiercingHE = json['alphaPiercingHE'];
    this.ap = json['ap'];
    this.sigma = json['sigma'];
    this.consumable = json['consumables'];
    this.isPaperShip = json['isPaperShip'];
    this.permoflage = json['permoflages'];
    this.battle = json['battles'];
  }

  Map<String, dynamic> toJson() {
    return {
      'alphaPiercingHE': this.alphaPiercingHE,
      'ap': this.ap,
      'sigma': this.sigma,
      'consumables': this.consumable,
      'isPaperShip': this.isPaperShip,
      'permoflages': this.permoflage,
      'battles': this.battle,
    };
  }
}

/// This is the `Ap` class
class Ap {
  double weight;
  double diameter;
  double drag;
  double velocity;
  double krupp;

  Ap.fromJson(Map<String, dynamic> json) {
    this.weight = json['weight'];
    this.diameter = json['diameter'];
    this.drag = json['drag'];
    this.velocity = json['velocity'];
    this.krupp = json['krupp'];
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': this.weight,
      'diameter': this.diameter,
      'drag': this.drag,
      'velocity': this.velocity,
      'krupp': this.krupp,
    };
  }
}
