class AddArticleToHabits < ActiveRecord::Migration
  def change
      add_column(:habits, :article, :string)

  end
end
