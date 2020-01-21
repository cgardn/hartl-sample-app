class AddMicropostAssociationToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :microposts
  end
end
