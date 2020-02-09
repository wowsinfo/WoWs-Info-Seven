import { Meta } from "./Meta";

/**
 * `Downloader` will check if meta status is ok or not so you don't need to check
 */
abstract class APIRepsonse {
    status?: string;
    meta?: Meta;

    constructor(json: any) {
        this.status = json.status;
        this.meta = new Meta(json.meta);
    }
}

export { APIRepsonse };
