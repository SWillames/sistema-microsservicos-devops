class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |error|
    render json: { error: "Parâmetro obrigatório ausente: #{error.param}" }, status: :bad_request
  end
end
