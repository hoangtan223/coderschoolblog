class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy 

	def self.search(search)
		if search
			where("title LIKE ?", "%#{search}%")
			.order(created_at: :desc)
		else
			all
			.order(created_at: :desc)
		end
	end

	def increase_view_count
		self.view_count += 1
		self.save
	end
end
