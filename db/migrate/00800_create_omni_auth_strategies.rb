class CreateOmniAuthStrategies < ActiveRecord::Migration[6.0]
  def change
    create_table :omni_auth_strategies do |t|
      t.string :name, null: false
      t.string :provider, null: false
      t.json :config, null: false
      t.timestamps
    end
  end
end
