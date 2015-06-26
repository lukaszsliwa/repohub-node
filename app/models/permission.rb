class Permission < ActiveRecord::Base
  belongs_to :user

  enum value: { :repositories_index => 100, :repositories_create => 101, :repositories_destroy => 102,
                :spaces_index => 200, :spaces_create => 201, :spaces_destroy => 202,
                :developers_index => 300, :developers_create => 301, :developers_destroy => 302,
                  :developers_allow => 303, :developers_deny => 304,
                :keys_index => 400, :keys_create => 401, :keys_destroy => 402 }
end
