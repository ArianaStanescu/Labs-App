class ApplicationController < ActionController::Base
  def hello
    render html: "hello world!"
  end

  def goodbye
    render html: "goodbye world!"
  end

  def extra
    render json:{
      "message": "hello world",
      "error": "goodbye"
    }
  end

  def newroute
    respond_to do |format|
      format.html { render html: "html route"}
      format.json { render json: { message: "json route" } }
    end
  end


end
