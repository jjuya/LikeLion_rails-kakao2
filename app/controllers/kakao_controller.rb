require 'objectmaker'
require 'parser'

class KakaoController < ApplicationController
  
  @@keyboard = Objectmaker::Keyboard.new
  @@message = Objectmaker::Message.new
  
  def keyboard
    # keyboard = {
    #   :type => "buttons",						
    #   buttons: ["현재 영화 랭킹", "잘자"]
    # }
    btn = ["네이버 영화 랭킹", "네이버 예매 랭킹", "잘자"]
    render json: @@keyboard.getBtnKey(btn)
  end

  def message
    
    btn = ["네이버 영화 랭킹", "네이버 예매 랭킹", "잘자"]
    
    user_msg = params[:content]
    
    sleeping = ["(자는중)", "-.-Zzzzz", "..zz", "..ZZ"]
    
    if user_msg == btn[0]
      parser = Parser::Movie.new
      result = parser.rank_movie.to_s
      msg = @@message.getMessage(result)
    elsif user_msg == btn[1]
      parser = Parser::Movie.new
      movies = parser.rank_ticketing
      msg = @@message.getMessage(movies.to_s)
    elsif user_msg == btn[2]
      msg = @@message.getMessage(sleeping.sample.to_s)
    end
    
    
    basic_keyboard = @@keyboard.getBtnKey(btn)
    
    basic_msg = {
      message: msg,
      keyboard: basic_keyboard
    }
    
    render json: basic_msg
  end
  
  def friend_add
    # 친구 추가
    User.create(
      user_key: params[:user_key],
      chat_room: 0
    )
    
    render nothing: true
  end
  
  def friend_del
    
    User.find_by(user_key: params[:user_key]).destroy
    
    render nothing: true
  end
  
  def chat_room
    
    user = User.find_by(user_key: params[:user_key])
    
    user.plus
    user.save
    
    render nothing: true
  end

end
