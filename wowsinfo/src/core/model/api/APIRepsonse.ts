import { Meta } from "./Meta";

class APIRepsonse {
    status?: string;
    meta?: Meta;

    constructor(json: any) {

    }
}

export { APIRepsonse };
