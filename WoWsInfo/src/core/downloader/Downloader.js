import { Guard } from "../util/SafeGuard";

class Downloader {
  constructor() {
    var a = {hello: {
      hello: {
        world: {
          world: {
            is: 99
          }
        }
      }
    }}
    let value = Guard(a, 'hello.hello.world.world.are', 0);
    console.log(value);
  }
}

export { Downloader };
