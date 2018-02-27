class Subject < ApplicationRecord
    self.primary_key = :code
end

has_and_belongs_to_many :users, :join_table => :users_roles
