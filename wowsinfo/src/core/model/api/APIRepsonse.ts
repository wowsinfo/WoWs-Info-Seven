import { Meta } from "./Meta";

abstract class APIRepsonse {
    status?: string;
    meta?: Meta;

    constructor(json: any) {
        this.status = json.status;
        this.meta = new Meta(json);
    }
}

export { APIRepsonse };
