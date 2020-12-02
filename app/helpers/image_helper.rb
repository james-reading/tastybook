module ImageHelper
  def recipe_image_attributes(recipe)
    img_attributes = {
      alt: recipe.name,
      src: asset_pack_path('media/images/placeholder-recipe.svg')
    }

    if recipe.image.attached?
      img_attributes.merge!(
        src: lowres_image_variant_url(recipe.image),
        data: {
          src: medium_image_variant_url(recipe.image),
        }
      )
    end

    img_attributes
  end

  def lowres_image_variant_url(image)
    rails_representation_url(image.variant(resize_to_fill: [20, ((20/21.0) * 9).round]))
  end

  def medium_image_variant_url(image)
    rails_representation_url(image.variant(resize_to_fill: [800, ((800/21.0) * 9).round]))
  end

  def large_image_variant_url(image)
    rails_representation_url(image.variant(resize_to_fill: [1200, ((1200/21.0) * 9).round]))
  end

  def medium_profile_image_url(user)
    if user && user.image.attached?
      rails_representation_url(user.image.variant(resize_to_fill: [200, 200]))
    else
      asset_pack_path('media/images/user-circle.svg')
    end
  end
end
