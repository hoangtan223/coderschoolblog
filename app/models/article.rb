class Article < ActiveRecord::Base
	def self.search(search)
		if search
			where("title LIKE ?", "%#{search}%")
		else
			all
		end
	end

	def increase_view_count
		self.view_count += 1
		self.save
	end
end
