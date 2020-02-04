import { WebsiteBuilder } from './WebsiteBuilder';

class UtilityWebsite implements WebsiteBuilder {
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

export { UtilityWebsite };
