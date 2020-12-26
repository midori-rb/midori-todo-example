define_error :unauthorized_error,
             :user_conflict_error

class ErrorRoute < Midori::API
  capture UnauthorizedError do
    Midori::Response.new(
      status: 401,
      body: {message: 'Unauthorized'}.to_json
    )
  end

  capture UserConflictError do
    Midori::Response.new(
      status: 409,
      body: {message: 'Username has been taken'}.to_json
    )
  end
end
