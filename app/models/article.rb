class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	has_many :taggings
	has_many :tags, through: :taggings

	def self.search(search)
		if search
			where("lower(title) LIKE ?", "%#{search.downcase}%")
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

	def generate_tags(tags_string)
		tag_array = tags_string.split(/\s*,\s*/)
		tag_array.each do |tag_string|
			unless (tag_string.blank?)
				new_tag = (Tag.find_by_tag_name tag_string) || Tag.new(tag_name: tag_string)
				self.tags << new_tag
			end
		end
	end
end