class TweetsController < ApplicationController
  def create
    if current_session
      user = @session.user
      @tweet = user.tweets.new(tweet_params)

      if @tweet.save
        render 'tweets/create'
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
      if @tweet.user == @session.user
        render json: {
          success: true
        }
      end
    else
      render json: {
        success: false
      }
    end
  end

  def index
    @tweets = Tweet.all.order(created_at: :desc)
    render 'tweets/index'
  end

  def index_by_user
    user = User.find_by(username: params[:username])

    if user
      @tweets = user.tweets
      render 'tweets/index'
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
