# frozen_string_literal: true

module Mocks
  def mock_success_service(service:, result:)
    service.expects(:call).once.returns(ServiceResult.new(true, result))
  end

  def mock_failed_service(service:, error_message:)
    service.expects(:call).once.returns(ServiceResult.new(false, {}, error_message))
  end

  class ServiceResult
    attr_reader :result, :success, :error_message

    def initialize(success, result = {}, error_message = '')
      @success = success
      @result = result
      @error_message = error_message
    end

    def success?
      success
    end
  end
end
