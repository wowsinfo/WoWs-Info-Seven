import { Meta } from "./Meta";

abstract class APIRepsonse {
    status?: string;
    meta?: Meta;

    constructor(json: any) {

    }
}

export { APIRepsonse };
