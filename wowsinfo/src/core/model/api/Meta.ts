class Meta {
    count?: number;
    page_total?: number;
    total?: number;
    limit?: number;
    page?: number;

    constructor(json: any) {
        this.count = json.count;
        this.page_total = json.page_total;
        this.total = json.total;
        this.limit = json.limit;
        this.page = json.page;
    }
}

export { Meta };
