class Recipe
  class Search
    include ActiveAttr::Attributes
    include ActiveAttr::AttributeDefaults
    include ActiveAttr::BasicModel
    include ActiveAttr::MassAssignment

    attribute :q
    attribute :user
    attribute :length, default: Recipe::LENGTHS
    attribute :course, default: Recipe::COURSES

    def run
      Recipe.search query_string, options
    end

    private

    def options
      prepare_where

      {
        where: where,
        includes: [:cuisine],
        fields: [:name],
        match: :word_start,
        order: order
      }
    end

    def query_string
      # This allows the form search to not display the * in the input
      q.blank? ? '*' : q
    end

    def where
      @where ||= {}
    end

    def prepare_where
      limit_to_user
      limit_by_length
      limit_by_course
    end

    def limit_to_user
      if user.present?
        where[:user_id] = user.id
      end
    end

    def limit_by_length
      pp length.present?
      if length.present?
        where[:length] = length
      end
    end

    def limit_by_course
      if course.present?
        where[:course] = course
      end
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
