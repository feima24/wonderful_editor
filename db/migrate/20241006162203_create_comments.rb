class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments, &:timestamps
    t.timestamps
  end
end
