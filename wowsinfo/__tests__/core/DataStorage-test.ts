import { equal } from 'assert';
import DataManager from '../../src/core/data/DataManager';

it('Singleton - same instance', () => {
    const a = DataManager.Instance;
    const b = DataManager.Instance;
    equal(a === b, true, 'A should be equal to B');
});
