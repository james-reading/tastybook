module ImageHelper
  def recipe_image_attributes(recipe)
    img_attributes = {
      alt: recipe.name
    }

    if recipe.image.attached?
      img_attributes.merge!(
        src: lowres_image_variant_url(recipe.image),
        data: {
          src: medium_image_variant_url(recipe.image),
        }
      )
    else
      img_attributes.merge!(
        data: { src: asset_pack_path('media/images/placeholder-recipe.svg') }
      )
    end

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
end
