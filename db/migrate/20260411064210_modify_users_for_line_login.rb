class ModifyUsersForLineLogin < ActiveRecord::Migration[8.1]
  def change
    # LINEログイン用のカラム追加
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :image, :string

    # LINEのID（uid）にインデックスを貼る（高速化と重複防止）
    add_index :users, [:provider, :uid], unique: true

    # メールアドレスの「必須（NOT NULL）」と「ユニーク制約」を外す
    # MySQLの場合は null: true に変更
    change_column_null :users, :email, true
    remove_index :users, :email
    add_index :users, :email # ユニークではない普通のインデックスとして再貼り
  end
end
