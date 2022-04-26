class ApplicationController < ActionController::API
    def hello
        render json: "HELL"
    end
end
