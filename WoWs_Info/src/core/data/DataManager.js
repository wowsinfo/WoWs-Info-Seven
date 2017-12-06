import { Achievement, CommanderSkill, GameMap, Consumable, Warship, Encyclopedia, Language } from './';

class DataManager {
  // Update everything from server
  static async updateLocalData() {
    // Language has to be saved in order to load other data correctly
    await Language.saveLanguage();
    await Encyclopedia.saveEncyclopedia();
    await Achievement.saveAchievement();
    await CommanderSkill.saveCommanderSkill();
    await GameMap.saveGameMap();
    await Consumable.saveConsumable();
    await Warship.saveWarship();
  }
}

export {DataManager};