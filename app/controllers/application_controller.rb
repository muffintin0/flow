class ApplicationController < ActionController::Base
  protect_from_forgery
  include AutoHtml

  PAGE_LIMIT = 20
  FEEDS_LIMIT = 1000

end
