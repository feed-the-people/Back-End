class NpoService

  def self.conn(uri)
    url = 'https://projects.propublica.org/nonprofits/api/v2/' + uri
    Faraday.new(url)
  end

  def self.get_nonprofits(term)
    response = conn('search.json').get do |req|
      req.params['q'] = term
    end
    results = JSON.parse(response.body, symbolize_names: true)[:organizations]
    results.map do |npo_data|
      Npo.new(npo_data)
    end
  end
end