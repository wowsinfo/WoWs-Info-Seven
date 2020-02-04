export interface WebsiteBuilder {
  /**
   * Get domain according to the server
   * - Usually it is just server but exception exists
   */
  getDomain(): string

  /**
   * Get the final url/
   */
  getUrl(): string

  /**
   * Render a list containing 
   */
  renderAccordion(): JSX.Element
}