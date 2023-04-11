class ApplicationController < ActionController::Base
  def hello
    render html: "hello world!"
  end

  def goodbye
    render html: "goodbye world!"
  end

  def extra
    render json:{
      "message": "hellow world",
      "error": "goodbye"
    }
  end

end
