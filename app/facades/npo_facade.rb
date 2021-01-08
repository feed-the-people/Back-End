class NpoFacade
  def self.search_npo(term)
    results = NpoService.get_nonprofits(term)
  end
end