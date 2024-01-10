class AddForeignKeysToTables < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :sessions, :user, foreign_key: true
    add_belongs_to :tweets, :user, foreign_key: true
  end
end
