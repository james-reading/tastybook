class Recipe
  class Randomizer < Search

    def run
      Recipe.search(body: body).first
    end

    private

    def body
      {
        size: 1,
        query: {
          function_score: {
            query: query,
            functions: [
              { random_score: {} }
            ],
            score_mode: 'sum',
            boost_mode: 'replace'
          }
        }
      }
    end

    def query
      Searchkick::Query.new(Recipe, query_string, options).body[:query]
    end
  end
end
