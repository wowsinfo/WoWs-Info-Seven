import { BasicLoader } from "./BasicLoader";
import { DATA_KEY, Cacheable } from "../../Cacheable";
import AsyncStorage from "@react-native-community/async-storage";

class AppLanguageLoader implements BasicLoader {
  key: DATA_KEY = DATA_KEY.user_app_language;
  
  load(): Cacheable {
    return AsyncStorage.getItem(this.key);
  }
}

export { AppLanguageLoader };
