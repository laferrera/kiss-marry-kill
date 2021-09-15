class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|    
      t.string :name, :null => false
      t.string :uid, :null => false
      t.integer :status, :null => false, default: 0
      t.integer :current_round, :null => false, default: 0
      t.references :question_set
      t.timestamps
    end
  end

    create_table :users do |t|    
      t.string :name, :null => false
      t.references :game

      t.timestamps
    end

    create_table :question_sets do |t|    
      t.string :name
    end

    create_table :questions do |t|    
      t.references :question_set
      t.string :option_1
      t.string :option_1_img_url
      t.string :option_2
      t.string :option_2_img_url
      t.string :option_3
      t.string :option_3_img_url
      t.timestamps
    end



end
