class ApplicationController < ActionController::Base
    private 
    
    def check_if_admin
        if not current_user.has_role? :admin 
            respond_to do |format|
                format.html { redirect_to root_path, alert: "No eres admin"}
            end
        end
    end
end
