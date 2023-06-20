# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_user!

  respond_to :html, :json

  # Returns response to the user both in the browser and in the JSON response.
  # Also allows JSON to include any flash 'message' that are normally sent to the browser.
  def render_response(info: nil, errors: [], path: root_path)
    @message = errors.any? ? errors.full_messages.join(', ') : info

    flash[:notice] = @message

    respond_to do |format|
      format.json
      format.html { redirect_to path }
    end
  end
end
