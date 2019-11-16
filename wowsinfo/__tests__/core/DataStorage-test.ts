import { equal } from 'assert';
import DataStorage from '../../src/core/util/DataStorage';

it('Singleton - same instance', () => {
    const a = DataStorage.Instance;
    const b = DataStorage.Instance;
    equal(a === b, true, 'A should be equal to B');
});
