class UserRoute < Midori::API
  post '/register' do
    req = JSON.parse(request.body)
    UserService.register(req['username'], req['password'])
    @status = 201
    ''
  end

  post '/login' do
    req = JSON.parse(request.body)
    {
      token: UserService.login(req['username'], req['password'])
    }.to_json
  end
end
