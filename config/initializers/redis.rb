# frozen_string_literal: true

Utils::Redis.connection = Redis::Namespace.new('Patrimonio', redis: Redis.new)
