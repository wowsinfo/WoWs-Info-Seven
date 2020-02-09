/// Meta should never be null so you don't need to check
class Meta {
    count?: number;
    page_total?: number;
    total?: number;
    limit?: number;
    page?: number;
    // If it's not null, it's hidden
    hidden?: object[];

    constructor(json: any) {
        this.count = json.count;
        this.page_total = json.page_total;
        this.total = json.total;
        this.limit = json.limit;
        this.page = json.page;
        this.hidden = json.hidden;
    }
}

export { Meta };
