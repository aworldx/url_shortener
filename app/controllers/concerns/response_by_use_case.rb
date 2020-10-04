# frozen_string_literal: true

module ResponseByUseCase
  def response_by_use_case(use_case)
    use_case.success? ? success_response(use_case) : fail_response(use_case)
  end

  def success_response(use_case)
    render json: { success: true, result: use_case.result }
  end

  def fail_response(use_case)
    render json: { success: false, error: use_case.error_message }
  end
end
