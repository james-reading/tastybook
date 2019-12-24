class Recipe
  class Search
    include ActiveAttr::Attributes
    include ActiveAttr::AttributeDefaults
    include ActiveAttr::BasicModel
    include ActiveAttr::MassAssignment

    attribute :q
    attribute :user

    def run
      prepare_where_object

      options = {
        where: where,
        includes: [:cuisine],
        fields: [:name],
        match: :word_middle,
        order: order
      }

      r = Recipe.search query_string, options
    end

    private

    def query_string
      # This allows the form search to not display the * in the input
      q.blank? ? '*' : q
    end

    def where
      @where ||= {}
    end

    def prepare_where_object
      limit_to_user if user
    end

    def limit_to_user
      where[:user_id] = user.id
    end

    def order
      if query_string == '*'
        { name: :asc }
      else
        { _score: :desc }
      end
    end
  end
end
