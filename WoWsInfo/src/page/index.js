// This is the menu that we could access from anywhere
export * from './common/Filter';
export * from './common/Loading';

// Go to this page when app is first launched
export * from './home/Menu';
export * from './home/Setup';
export * from './home/Friend';
export * from './home/RS';
export * from './home/Search';

export * from './wiki/Consumable';
export * from './wiki/BasicDetail';
export * from './wiki/CommanderSkill';
export * from './wiki/Achievement';
export * from './wiki/Map';
export * from './wiki/Collection';
export * from './wiki/Warship';
export * from './wiki/WarshipDetail';
export * from './wiki/WarshipFilter';
export * from './wiki/WarshipModule';
export * from './wiki/SimilarGraph';

export * from './player/Statistics';
export * from './player/PlayerAchievement';
export * from './player/Rating';
export * from './player/Graph';

export * from './clan/ClanInfo';

export * from './settings/About';
export * from './settings/License';
export * from './settings/SupportMe';
export * from './settings/ProVersion';
import Settings from './settings/Settings';
export { Settings };
