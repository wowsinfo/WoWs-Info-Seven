# Class design
Code refacoring is necessary for maintenance purpose.

## DataStorage
Singleton pattern will be used to replace global and static functions. 
It will take care of data loading and saving.

### DataDownloader
Download data from the server and throw them into DataStorage to save them

## Util
A class with static functions. Basically, a collection of individual functions. 

## UI
All components will inherit a base class for common behaviours. 
It should include whether this is a pro feature, how to deal with loading and error state. 
All components will inherit `WoWsComponent`.

## Calculation
Choose different behaviours when different objects are passed in. 
This is mainly for Personal Rating. Data should not be mutated. 

***
UI should only render UI and everything should be passed as an object to other classes.
