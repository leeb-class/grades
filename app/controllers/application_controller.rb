class ApplicationController < ActionController::Base
    before_action :load_settings

    def load_settings
        @settings = {
            title: ENV['TITLE'],
            subtitle: ENV['SUBTITLE'],
            page_title: ENV['PAGE_TITLE']
        }
    end
end
