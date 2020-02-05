# My diary for WoWs Info
This will track what I have done today and what I will do tomorrow.
~~~
Template
## /02/2019
### What have I done?
### What to do tomorrow?
~~~

## 05/02/2019
### What have I done?
Completed `Preference` with senpai
### What to do tomorrow?
Wiki and all other backend if possible

## 04/02/2019
### What have I done?
Added `package.json` inside `src` folder to use absolute path and prevent `../../` chaining. 
Fixed `StaturBar` issue on IOS. The animation looks ok and it is not that distracting.
### What to do tomorrow?
More `json2ts`. It will be really handly if you want to convert json into typescipt interfaces.

## 01/02/2019
### What have I done?
Added `color` and it was really useful to tackle colour related problems. 
Therefore, many theme related issues were solved and the colour is even better now. 
`Bottom Navigation` is now white in light mode and `SearchPage` now has a better search bar. 
### What to do tomorrow?
Continue with `Website`, `Wiki` and `Real-time` maybe.

## 31/01/2019
### What have I done?
Changed to `yarn` (`npm` is a bit hard to use at time). 
More UX design. Adding a header and using `Accordion` is indeed really good. 
`SearchBar` is a bit shorter than the `Header` so it can be a bit weird.
### What to do tomorrow?
Considering of breaking pages into page components. 
Therefore, a page is merely `Header` + `Content`. 
In this way, it can support different layouts for tablets and many more. 
More UX design is necessary and maybe try to add `react-native-shifting-text`. 
It is still experienmental and I should allow passing in custom text components. 

## 30/01/2019
### What have I done?
Nothing
### What to do tomorrow?
Track what we have discussed
- Add pro button in HomePage
- Try WebsitePage (Tab or List)
- Add header to Wikipedia
- Header or not?
- Use 2 only in Realtime
- How to choose - go to another page

## 28/01/2019
### What have I done?
More UX design. I found a JSON to TS converter and I will probably use it for API models. Some more ideas for the `HomePage`. 
Maybe just make it simpler and display a huge `Welcome Back, HenryQuan` with two button below it (`Check for latest news` and `Check my statistics`). 
With `WoWs Info RE`, version and settings on top?
### What to do tomorrow?
More UX design and add more models for `preference`

## 27/01/2019
### What have I done?
Fixed node packages. I was designing and considering the look and feel of this new update. It is good to have unique looks on different platforms but I won't do that. This update aims to provide better user experience and stability. 
`WebView` has been added to show news with some minimal changes
### What to do tomorrow?
Adjust UI and focus on English version

## 21/01/2019
### What have I done?
Added one feature to TODO list
### What to do tomorrow?
Probably, it is time to start working on this again

## 07/01/2019
### What have I done?
Upgraded and fixed packages. I need to tell Maurice senpai...
### What to do tomorrow?
Probably nothing until my supp

## 23/12/2019
### What have I done?
Nothing except meeting with senpai
### What to do tomorrow?
???

## 22/12/2019
### What have I done?
Cleaned up the repo with bfg (removed the framework and it should be smaller now). Added `PlayerAccount` and `GameServer`. 
### What to do tomorrow?
I feel like there are still some issues with the current model. How to update local data? You don't need to update wiki data unless there is an update. All you need to do it to diff new data with old data and display it. However, how about preference? The user could update it anytime. How about putting it inside the provider? I still don't know...

## 21/12/2019
### What have I done?
`Cacheable` now has two children, `Preference` and `CachedWiki`
### What to do tomorrow?
More models

## 20/12/2019
### What have I done?
Some more designs on OneNote
### What to do tomorrow?
Actually write some codes and see if it works

## 19/12/2019
### What have I done?
Updated folder structure and lots of refactoring have been done. 
Many new issues have been discovered and I am starting to write more downloaders and models. 
That's a lot of work to do but it is good this way. Do it slowly and don't rush.
### What to do tomorrow?
Write some `APIDownloader` and maybe more updates on folder structure

## 15/12/2019
### What have I done?
Meeting with senpai and some decisions were made. `Home` is now updated and `Loading` is added
### What to do tomorrow?
More loading and maybe test update theme

## 14/12/2019
### What have I done?
`Settings` has been updated to show a section list but is it really a good idea? 
`AppLogo` now takes a `size` and version number is added as well
### What to do tomorrow?
First meeting with senpai and some dicussions on some topics

## 06/12/2019
### What have I done?
`Setup` has been added but it only has 3 titles now without any functionalities. Privacy policy & term of use were added (template only) but three languages are too much... 
I have to work harder maybe with my senpai! If I can deal with data correctly, the rest is just copy and paste my old code which shouldn't be really hard
### What to do tomorrow?
More models, API and DataManager.

## 04/12/2019
### What have I done?
`BasicDownloader` and `APIResponse`. There will be lots of classes but this is the only to make sure it is safe. 
Therefore, I have to write lots of code for this... but it is good in the long run
### What to do tomorrow?
Add more models

## 02/12/2019
### What have I done?
Updated to `1.0.7/1.6.6` to fix some bugs and tabs were added to log files
### What to do tomorrow?
Same as below, `DataManager`

## 29/11/2019
### What have I done?
Mac OS on Surface with the help of [this repo](https://github.com/hacker1024/Hackintosh-Clover-SurfacePro3). It works really well and I am quite happy with it. `BottomButton` was created but it is kinda limited now. Some components were moved to `common/` folder. `Welcome` is done I think and for `Agreement`, I have added two button at the bottom. If the user declines, he/she will either go back to home or simply dismiss the alert
### What to do tomorrow?
My exams is next Monday so I think I will do some serious study. The issue now is that I am still not clear on what I need to do for `DataManager`. However, don't need to rush. I will reuse many codes from the old project (not really) so it should be fine
