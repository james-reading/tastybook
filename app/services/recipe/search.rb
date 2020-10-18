class Recipe
  class Search
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :q
    attribute :user
    attribute :length, default: Recipe::LENGTHS
    attribute :course, default: Recipe::COURSES
    attribute :user_recipes, :boolean, default: false
    attribute :friend_recipes, :boolean, default: false
    attribute :liked_recipes, :boolean, default: false
    attribute :page, :integer, default: 1
    attribute :per_page, :integer, default: 25

    def run
      @results = Recipe.search query_string, options
    end

    def page
      super || 1
    end

    def last_page?
      page >= total_pages
    end

    def total_count
      results.total_count
    end

    private

    attr_reader :results

    def options
      prepare_where

      {
        where: where,
        fields: [:name],
        match: :word_start,
        order: order,
        page: page,
        per_page: per_page,
        includes: [{ image_attachment: :blob }, :cuisine, :user]
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
      limit_by_length
      limit_by_course
      limit_by_user
    end

    def limit_by_length
      if length.present?
        where[:length] = length
      end
    end

    def limit_by_course
      if course.present?
        where[:course] = course
      end
    end

    def limit_by_user
      user_ids = []
      
      if user_recipes
        user_ids << user.id
      end

      if friend_recipes
        user_ids += user.friends.pluck(:friend_id)
      end

      if liked_recipes
        where[:_or] = [{ user_id: user_ids }, { liked_user_ids: user.id }]
      else
        where[:user_id] = user_ids
      end
    end

    def order
      if query_string == '*'
        { name: :asc }
      else
        { _score: :desc }
      end
    end

    def total_pages
      (total_count.to_f / per_page).ceil
    end
  end
end
