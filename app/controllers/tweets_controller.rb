class TweetsController < ApplicationController
  def create
    if current_session
      user = @session.user
      @tweet = user.tweets.new(tweet_params)

      if @tweet.save
        render json: {
          tweet: {
            username: user.username,
            message: @tweet.message
          }
        }
      else
        render json: {
          success: false
        }
      end
    end
  end

  def destroy
    @tweet = Tweet.find_by(id: params[:id])

    if current_session and @tweet and @tweet.destroy
      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end

  def current_session
    token = cookies.signed[:twitter_session_token]
    @session = Session.find_by(token: token)
  end
end
