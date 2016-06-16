class CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		respond_to do |format|
			if @comment.save
				format.json do
					render :json => {:success => @comment.valid?, :comment => @comment.body, :name => @comment.name }
				end
			else
				format.json do
					render :json => {:success => @comment.valid?, :errors => @comment.errors }
				end
			end
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:body, :name, :article_id)
	end
end