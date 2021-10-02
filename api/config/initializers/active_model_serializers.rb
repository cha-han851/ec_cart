# frozen_string_literal: true

# ActiveModel::Serializer.config.adapter = ActiveModelSerializers::Adapter::JsonApi
ActiveModelSerializers.config.adapter = :json_api
ActiveModel::Serializer.config.key_transform = :underscore
