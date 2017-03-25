# frozen_string_literal: true

module SlackEvents
  class UserChange
    def initialize(collection, params)
      @collection = collection
      @event = params[:event]
    end

    def execute
      new_user? ? create_user : update_user
    end

    def new_user?
      user_id && !User.exists?(slack_id: user_id)
    end

    private

    attr_reader :collection, :event, :user

    def user_id
      @user_id ||= event[:type] == 'user_change' ? event.dig(:user, :id) : event[:user]
    end

    def create_user
      data = SlackAPI.user_info(collection.bot_access_token, user_id)

      save_user(data)
    end

    def update_user
      save_user(event)
    end

    def save_user(data)
      User.save_profile(
        collection: collection,
        id: user_id,
        name: data.dig(:user, :name),
        avatar: data.dig(:user, :profile, :image_72)
      )
    end
  end
end
