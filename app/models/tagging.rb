class Tagging < ActiveRecord::Base
	belongs_to :arcticle
	belongs_to :tag
end
