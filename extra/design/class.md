# Class design
Code refacoring is necessary for maintenance purpose.

## Data
Singleton pattern will be used to replace global and static functions. 
It will take care of data downloader, loader and storage. 

## Util
A class with static functions. Basically, a collection of individual functions. 

## UI
All components will inherit a basic class for common behaviours (like pro features). 
Mobile and Tablet should be added as root components. 

## Calculation
Choose different behaviours when different objects are passed in. 
This is mainly for Personal Rating. Data should not be mutated. 
