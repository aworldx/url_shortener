# frozen_string_literal: true

class CreateShortUrls < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    create_table :short_urls do |t|
      t.string :original_url, null: false, default: ''
      t.string :short_url, null: false, default: ''
      t.integer :clicks_count, null: false, default: 0
      t.timestamps
    end

    add_index :short_urls, :original_url, algorithm: :concurrently
    add_index :short_urls, :short_url, unique: true, algorithm: :concurrently
  end
end
