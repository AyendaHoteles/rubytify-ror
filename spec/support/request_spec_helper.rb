# frozen_string_literal: true

# Helper to parse JSON response to ruby hash
module RequestSpecHelper
  def json_body
    JSON.parse(response.body)
  end
end
