class CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		respond_to do |format|
			if @comment.save
				format.json do
					render :json => {:success => @comment.valid?, :comment => @comment.body }
				end
			end
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:body, :article_id)
	end
end