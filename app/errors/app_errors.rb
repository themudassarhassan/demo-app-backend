module AppErrors
  class UnauthorizedUser < ActiveRecord::RecordNotFound
    def message
      'unauthorized user'
    end

    def http_status
      403
    end
  end
end
