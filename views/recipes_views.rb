module RecipeViews

  def recipe_show_view(recipe)
    puts
    puts "Here's the recipe:"
    puts "Recipe #{recipe.id} - #{recipe.title}"
    puts "By: #{recipe.chef}"
    puts "This will take you #{recipe.prep_time}"
    puts "Ingredients: #{recipe.ingredients}"
    puts "Directions: #{recipe.directions}"
  end

  def recipes_index_view(recipes)
    puts "Here are the recipes:"
    recipes.each do |recipe|
      puts "Recipe #{recipe.id} - #{recipe.title}"
      puts "By: #{recipe.chef}"
      puts "This will take you #{recipe.prep_time}"
      puts "Ingredients: #{recipe.ingredients}"
      puts "Directions: #{recipe.directions}"
    end
  end

end