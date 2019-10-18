class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text       :message, null: false
      t.references :movie, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end

    add_index :comments, [:user_id, :movie_id], unique: true
  end
end
