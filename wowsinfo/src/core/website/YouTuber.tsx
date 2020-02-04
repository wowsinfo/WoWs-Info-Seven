import { WebsiteBuilder } from './WebsiteBuilder';

class Youtuber implements WebsiteBuilder {
  getDomain(): string {
    throw new Error('Method not implemented.');
  }  
  
  getUrl(): string {
    throw new Error('Method not implemented.');
  }
  
  renderAccordion(): JSX.Element {
    throw new Error('Method not implemented.');
  }
}

export { Youtuber };
