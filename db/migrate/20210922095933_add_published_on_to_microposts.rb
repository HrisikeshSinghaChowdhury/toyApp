class AddPublishedOnToMicroposts < ActiveRecord::Migration[6.1]
  def change
    add_column :microposts, :published_on, :datetime
  end
end
