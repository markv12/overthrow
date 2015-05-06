class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
   protect_from_forgery # See ActionController::RequestForgeryProtection for details

   # From authlogic
   helper_method :current_user_session, :current_user, :redirect_back_or_default

   private
   def current_user_session
     @current_user_session ||= UserSession.find
   end

   def current_user
     @current_user ||= current_user_session && current_user_session.user
   end

   def redirect_back_or_default(default)
     redirect_to(session[:return_to] || default)
     session[:return_to] = nil
   end

   def authenticate_admin
      current_user_admin = false
      if current_user
        if current_user.admin
          current_user_admin = true
        end
      end
      redirect_to new_user_session_path unless current_user_admin
   end

   def self.pluck_to_hash(keys)
     pluck(*keys).map{|pa| Hash[*keys.zip(pa).flatten]}
   end
end
