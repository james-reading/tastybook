class Recipe
  class Search
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :q
    attribute :user
    attribute :length, default: Recipe::LENGTHS
    attribute :course, default: Recipe::COURSES
    attribute :liked_only, :boolean, default: false
    attribute :exclude_friends, :boolean, default: false
    attribute :page, :integer, default: 1
    attribute :per_page, :integer, default: 25

    def run
      @recipes = Recipe.search query_string, options
    end

    def page
      super || 1
    end

    def last_page?
      page >= total_pages
    end

    private

    def options
      prepare_where

      {
        where: where,
        fields: [:name],
        match: :word_start,
        order: order,
        page: page,
        per_page: per_page,
        includes: [{ image_attachment: :blob }, :cuisine, :likes]
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
      limit_by_liked_only
    end

    def limit_to_user
      if user.present?
        where[:user_id] = user.id
      end
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

    def limit_by_liked_only
      if liked_only
        where[:liked_user_ids] = user.id
      end
    end

    def order
      if query_string == '*'
        { name: :asc }
      else
        { _score: :desc }
      end
    end

    def total_count
      @recipes.total_count
    end

    def total_pages
      (total_count.to_f / per_page).ceil
    end
  end
end
