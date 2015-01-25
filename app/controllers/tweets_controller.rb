class TweetsController < ApplicationController

	before_action :authenticate_user! # ! means raise error if not working

	def new
		@tweet = Tweet.new
		@tweets = current_user.tweets
	end

	def create
# -		@tweet = Tweet.create(tweet_params)

		@tweet = Tweet.new(tweet_params) # creates new instance of Tweet
		@tweet.user = current_user
		@tweets = current_user.tweets

		if @tweet.save # saves it to the database
			flash.now[:success] = "Tweet Created"
		end
 		render 'new'
 	end

 	def index
 		# All tweets but not our own.
 		@tweets = Tweet.all.reject{ |tweet|  tweet.user == current_user }
 		@relationship = Relationship.new
 	end

	private

	def tweet_params
		# Tweet params only permit content.
		params.require(:tweet).permit(:content)
	end
end
