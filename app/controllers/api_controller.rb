class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:check]
  def check
    log_text = params[:log_text]
    puts ""
    log_text = log_text.gsub("!n!","<br>")
    showlog=ShowLog.new
    showlog.log=log_text
    showlog.time=params[:time]
    showlog.save
    render json: {result:"yes"}

  end
  def test
    render json: {result:"as"}
  end

end
