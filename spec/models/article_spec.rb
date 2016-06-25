require 'rails_helper'

describe Article do
  describe '.generate_tags' do
    it 'works' do
      article = Article.new
      article.generate_tags('tag1')

      expected_tag = Tag.new(tag_name: 'tag1')

      expect(article.tags.length).to eq 1
      expect(article.tags.first).to have_attributes(:tag_name => 'tag1')
    end
  end
end
