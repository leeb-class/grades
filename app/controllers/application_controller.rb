class ApplicationController < ActionController::Base
    before_action :load_settings

    def load_settings
        @settings = {
            name: ENV['NAME'],
            semester: ENV['SEMESTER'],
        }
    end
end
