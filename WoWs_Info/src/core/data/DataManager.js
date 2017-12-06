import { Achievement, CommanderSkill, GameMap, Consumable, Warship, Encyclopedia } from './';

class DataManager {
  // Update everything from server
  static async updateLocalData() {
    await Achievement.saveAchievement();
    await CommanderSkill.saveCommanderSkill();
    await Encyclopedia.saveEncyclopedia();
    await GameMap.saveGameMap();
    await Consumable.saveConsumable();
    await Warship.saveWarship();
  }
}

export {DataManager};