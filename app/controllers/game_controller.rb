class GameController < ApplicationController
  include ActionController::Live

  def events
    3.times do |n|
      response.stream.write "{n} Is a Number \n\n"
      sleep 2
    end
  ensure
    response.stream.close
  end

end
