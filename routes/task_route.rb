class TaskRoute < Midori::API
  get '' do
    user = UserService.auth!(request)
    user.tasks.map do |task|
      {
        id: task.id,
        title: task.title,
        status: task.status,
        created_time: task.created_time,
      }
    end.to_json
  end

  post '' do
    user = UserService.auth!(request)
    req = JSON.parse(request.body)
    user.add_task(Task.new(
      title: req['title'],
    ))
    @status = 201
    ''
  end

  put '/:id' do
    user = UserService.auth!(request)
    req = JSON.parse(request.body)
    task = Task.where(id: request.params['id'])&.first
    raise UnauthorizedError unless user.id == task.user_id
    task.update(
      status: req['status'],
    )
    ''
  end

  delete '/:id' do
    user = UserService.auth!(request)
    task = Task.where(id: request.params['id'])&.first
    raise UnauthorizedError unless user.id == task.user_id
    task.delete
    ''
  end
end
