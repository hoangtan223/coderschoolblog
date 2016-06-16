class Comment < ActiveRecord::Base
  belongs_to :article

  validates :body, presence: true 
  validates :name, presence: true 
end
