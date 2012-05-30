require_dependency 'password'

class ApplicationController < ActionController::Base
  protect_from_forgery
end
