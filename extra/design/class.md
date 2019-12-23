# Class design
Code refacoring is necessary for maintenance purposes. Take your time while designing your app but make sure it will be done correctly.

## DataManager
Singleton pattern will be used to replace global and static functions. 
It will take care of data loading and saving.

### Loader
It will load all kinds of data back into DataManager. There should be lots of classes just to load one or related data.

### Downloader
Download data from the server and throw them into DataManager to save them. There will also be many downloaders just to download data from one API.

## Util
A class with static functions. Basically, a collection of individual functions. 

## UI
All components will implement a base class for common behaviours. 
It should include whether this is a pro feature, how to deal with loading and error state. 
All components will implement `WoWsComponent`.

## Models
### Calculation
Choose different behaviours when different objects are passed in. 
This is mainly for Personal Rating. Data should not be mutated. 

### UserTheme
This merely handles theme related functions and it is a wrapper around Theme from react native paper.
