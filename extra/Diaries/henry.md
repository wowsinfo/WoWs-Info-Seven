# My diary for WoWs Info
This will track what I have done today and what I will do tomorrow.
~~~
Template
## /04/2020
### Summary
### What to do tomorrow?
~~~

## 14/04/2020
### Summary
Everything can be downloaded and saved properly. This means that `the backend` is fine now. It is time to do `the UI`. It has been so long and finally the first step is done. 
### What to do tomorrow?

## 13/04/2020
### Summary
`APIParser` has been added but I don't know who should handle downloading more data. I think that parser should handle it. Just rewrite the download method or?? maybe the parser itself can handle it. I can just return a list of data and `parse` function should merge all of them into one? It shouldn't be that challenging. All parsers are done I think for now. I will handle data update now. `CachedData` should be closed after all data are read into memory. Only when it is updating data, it should be reopened again. Server language and game server can be set by the user now and some animations are also done. It can kinda distract users from the long waiting time I think. Next step, downloading all data. So far, enclopedia was fine and it is saved properly. I think my hardwork wasn't nothing. I will just do the UI slowly I guess. If I need anything, I will add it from the models. Let's see if this works.
### What to do tomorrow?
Download all data and make sure they are saved locally. The read speed was quite good and it didn't enough take a second to load the app.

## 12/04/2020
### Summary
I will try to complete all models today. It was smooth kinda. The most challenging ship wiki is done... 
I still have a few to do but I think I can finish all of them today hopefully. 
It is about done. Only data from GitHub left now but they are not that complicated. Test was really useful to spot my mistakes but I don't know how you can test widgets. 
I am sharing some codes from other models because some of them overlap. This time, it is definitely better and I feel like I am way faster than before. Am I getting better? 
The last rewrite was probably a year ago. Probably more than that. After this rewrite, I won't rewrite anymore and will focus on new features. 
I think I will work on `CachedData` soon. Models are not perfect yet but at least, I know how to deal with it. 
### What to do tomorrow?
`CachedData` first and then `Parser/Downloader`.

## 11/04/2020
### Summary
More models are added. I will try reading some local json files and see if they work as expected. `Parser` should do a bit work I think because I am not gonna save meta and status. If all models work, I can start working on the UI and keep adding things to the backend? I am doing tests and it is about 50% done but I will use python and try drawing the ap penetration curve for every ships if possible. 
### What to do tomorrow?
Complete all models and pass all tests. Start working on `Parser` and complete `CachedData`.

## 10/04/2020
### Summary
Back again. I was extracting data from the game and there will be more data available in wiki. I just remember some data are only saved in the memory so only wiki should be saved locally. `Preference` is now completed (kinda). However, theme colour, app brightness and app locale are still not saved. `Hive` can save value really quickly so I call just call preference and get the value. JSON is also used and I think I might actually just write to hive with keys. I think it should work fine because wargaming uses key quite a lot. In this way, it is all about key but I need to test and see if the performance is great enough. If it is not good, I will just drop the box and read it from json. All `Preference` is done including saving app theme colour, app locale and app theme mode. It is like how I saved data with `global` but everything is wrapped with a singleton class. Hive reads everything into memory but for wiki, it is often not necessary to load everything. I just hope it won't eat all my memories.
### What to do tomorrow?
Caching wiki data and data from GitHub. If this works, I am closer to a working backend. Most models in wows don't need to be saved so I don't really need to write those two methods. 

## 07/04/2020
### Summary
What I am doing now is basically what I did in the react native version but I wrap everything inside a class. The main issue of the old one is that there are too many code inside ui. All calculations should be done inside the model and it should simply returns the value I need. The main improvement of this rework is to seperate ui and calculation. `Hive` is really fast but I think I will still use json with it because I don't want to write so many adapaters. For simple entries, `Hive` is amazing. Dart also has the filter method so I think filtering ships should be fine. `ShiftingText` has added and it should work on Localization. It is quite fancy but I don't think my users actually care but this is the detail that I care about. 
### What to do tomorrow?
Tomorrow, I will be working on data and more models. API request is also another thing that I need to work on. With all of them are good. I can start working on the UI and probably it should be faster.

## 06/04/2020
### Summary
I actually implemented `Localization` yesterday so today, I am focusing on models. There are two kinds of data that needs to be saved. `Preference` and `CachaedWiki`. Preference can be edited but CachedWiki cannot, except when data should be updated. My next goal is to implement the data saving and auto update part. With the backend ready, UI should be easy. However, I need to break down Pages into widgets or so called `Fragment`. 
### What to do tomorrow?
More models.

## 05/04/2020
### Summary
Played with platform widget but I decided to use it later. Now, theme and brightness can be changed dynamically. Locale will be supported when I have added `Localization`. `LoadingOverlay` is now `InitialPage` and it loads data from GitHub and WG server. It does more (like loading data to memory) but when it is done, it will push to the `HomePage`. Then, the user can start using the app. I am really worried about my users in China because some ISP blocked the API and I don't know how to bypass it right now.
### What to do tomorrow?
Finalise `HomePage` and maybe `Localization`.

## 04/04/2020
### Summary
Back from `JSON: Become TS` and I was learning Kotlin and Swift. I am doing some UI today. `LoadingOverlay` is done with the help of `Theme` for theming, `Builder` for getting the theme and `PlatformWidget` to render IOS widgets on IOS. Of course, there are way more. I will try to keep the UI unchanged as much as possible so that my users won't be comfused that much. 
### What to do tomorrow?
More UI and maybe `Localization` as well. More on GitHub...

## 26/03/2020
### Summary
Mimic the original `HomePage` back in early 2017 and fade in the new one. It has been three years. This will be last and final rewrite. Flutter is indeed better for me but I will still learn React Native and native. I am not gonna get any jobs now so I can focus on my apps now. This time, I will make it great so that I don't have to rewrite anymore. My habit app is almost done and I will publish it soon for public testing. SVG logo has been added to have a better icon for Android. I will just keep the old logo since all of users are used to that logo. An alternative logo has been added for IOS. I still don't know how to change the logo for Android apps. 

Models for `WoWs (Player)` have been generated. Only `Wiki` and `GitHub` left now. Some models are shared which is great because it can reduce code duplications.
### What to do tomorrow?
The converter is so good. Maybe I should make it a bit better?

## 25/02/2020
### Summary
Nothing. I was working the 1.0.7.1 update. Now, users are not really happy with me but whatever. I will keep making this app and make it better no matter what.
### What to do tomorrow?
I am taking a break from WoWs Info and working on my [HabitApp](https://github.com/HenryQuan/HabitApp).

## 14/02/2020
### Summary
Fixed many bugs and many improvements for the old version. 
Started working on IAP and it will be available at a reduced price.
### What to do tomorrow?

## 11/02/2020 - 13/02/2020
### Summary
Did some research on Native UI module

## 10/02/2020
### Summary
Converted AppDelegate to `Swift` and created a bridging header for Swift. 
Objective-C is great but Swift is just more modern and easier for me. 
This is also part of the preparation for native modules (e.g. Charts). 
Android is now using `Kotlin`. Same reason as IOS. 
Added `WoWsAPI` to `PostMan` for easier development.
### What to do tomorrow?
More API!!

## 09/02/2020
### Summary
Added more functions in `APIDownloader` and some more header comments. 
Is it too much codes just for so little? 
I don't know but I think this is good for the long run. 
### What to do tomorrow?
Even more `API`?

## 08/02/2020
### Summary
Meeting with senpai. Mainly focused on `API`
### What to do tomorrow?
More `API`?

## 05/02/2020
### Summary
Completed `Preference` with senpai
### What to do tomorrow?
Wiki and all other backend if possible

## 04/02/2020
### Summary
Added `package.json` inside `src` folder to use absolute path and prevent `../../` chaining. 
Fixed `StaturBar` issue on IOS. The animation looks ok and it is not that distracting.
### What to do tomorrow?
More `json2ts`. It will be really handly if you want to convert json into typescipt interfaces.

## 01/02/2020
### Summary
Added `color` and it was really useful to tackle colour related problems. 
Therefore, many theme related issues were solved and the colour is even better now. 
`Bottom Navigation` is now white in light mode and `SearchPage` now has a better search bar. 
### What to do tomorrow?
Continue with `Website`, `Wiki` and `Real-time` maybe.

## 31/01/2020
### Summary
Changed to `yarn` (`npm` is a bit hard to use at time). 
More UX design. Adding a header and using `Accordion` is indeed really good. 
`SearchBar` is a bit shorter than the `Header` so it can be a bit weird.
### What to do tomorrow?
Considering of breaking pages into page components. 
Therefore, a page is merely `Header` + `Content`. 
In this way, it can support different layouts for tablets and many more. 
More UX design is necessary and maybe try to add `react-native-shifting-text`. 
It is still experienmental and I should allow passing in custom text components. 

## 30/01/2020
### Summary
Nothing
### What to do tomorrow?
Track what we have discussed
- Add pro button in HomePage
- Try WebsitePage (Tab or List)
- Add header to Wikipedia
- Header or not?
- Use 2 only in Realtime
- How to choose - go to another page

## 28/01/2020
### Summary
More UX design. I found a JSON to TS converter and I will probably use it for API models. Some more ideas for the `HomePage`. 
Maybe just make it simpler and display a huge `Welcome Back, HenryQuan` with two button below it (`Check for latest news` and `Check my statistics`). 
With `WoWs Info RE`, version and settings on top?
### What to do tomorrow?
More UX design and add more models for `preference`

## 27/01/2020
### Summary
Fixed node packages. I was designing and considering the look and feel of this new update. It is good to have unique looks on different platforms but I won't do that. This update aims to provide better user experience and stability. 
`WebView` has been added to show news with some minimal changes
### What to do tomorrow?
Adjust UI and focus on English version

## 21/01/2020
### Summary
Added one feature to TODO list
### What to do tomorrow?
Probably, it is time to start working on this again

## 07/01/2020
### Summary
Upgraded and fixed packages. I need to tell Maurice senpai...
### What to do tomorrow?
Probably nothing until my supp

## 23/12/2019
### Summary
Nothing except meeting with senpai
### What to do tomorrow?
???

## 22/12/2019
### Summary
Cleaned up the repo with bfg (removed the framework and it should be smaller now). Added `PlayerAccount` and `GameServer`. 
### What to do tomorrow?
I feel like there are still some issues with the current model. How to update local data? You don't need to update wiki data unless there is an update. All you need to do it to diff new data with old data and display it. However, how about preference? The user could update it anytime. How about putting it inside the provider? I still don't know...

## 21/12/2019
### Summary
`Cacheable` now has two children, `Preference` and `CachedWiki`
### What to do tomorrow?
More models

## 20/12/2019
### Summary
Some more designs on OneNote
### What to do tomorrow?
Actually write some codes and see if it works

## 19/12/2019
### Summary
Updated folder structure and lots of refactoring have been done. 
Many new issues have been discovered and I am starting to write more downloaders and models. 
That's a lot of work to do but it is good this way. Do it slowly and don't rush.
### What to do tomorrow?
Write some `APIDownloader` and maybe more updates on folder structure

## 15/12/2019
### Summary
Meeting with senpai and some decisions were made. `Home` is now updated and `Loading` is added
### What to do tomorrow?
More loading and maybe test update theme

## 14/12/2019
### Summary
`Settings` has been updated to show a section list but is it really a good idea? 
`AppLogo` now takes a `size` and version number is added as well
### What to do tomorrow?
First meeting with senpai and some dicussions on some topics

## 06/12/2019
### Summary
`Setup` has been added but it only has 3 titles now without any functionalities. Privacy policy & term of use were added (template only) but three languages are too much... 
I have to work harder maybe with my senpai! If I can deal with data correctly, the rest is just copy and paste my old code which shouldn't be really hard
### What to do tomorrow?
More models, API and DataManager.

## 04/12/2019
### Summary
`BasicDownloader` and `APIResponse`. There will be lots of classes but this is the only to make sure it is safe. 
Therefore, I have to write lots of code for this... but it is good in the long run
### What to do tomorrow?
Add more models

## 02/12/2019
### Summary
Updated to `1.0.7/1.6.6` to fix some bugs and tabs were added to log files
### What to do tomorrow?
Same as below, `DataManager`

## 29/11/2019
### Summary
Mac OS on Surface with the help of [this repo](https://github.com/hacker1024/Hackintosh-Clover-SurfacePro3). It works really well and I am quite happy with it. `BottomButton` was created but it is kinda limited now. Some components were moved to `common/` folder. `Welcome` is done I think and for `Agreement`, I have added two button at the bottom. If the user declines, he/she will either go back to home or simply dismiss the alert
### What to do tomorrow?
My exams is next Monday so I think I will do some serious study. The issue now is that I am still not clear on what I need to do for `DataManager`. However, don't need to rush. I will reuse many codes from the old project (not really) so it should be fine
