class AdminController < ApplicationController

  protected
    def authenticate
      authenticate_or_request_with_http_basic do |username, password|
        puts "" + ((CREDENTIALS[username] == password) && username=='admin').to_s
        ((not CREDENTIALS[username].nil?)  && (CREDENTIALS[username] == password)) && username=='admin'
      end
    end
end
