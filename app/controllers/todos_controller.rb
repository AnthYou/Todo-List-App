class TodosController < ApplicationController
  def index
    @todos = policy_scope(Todo)
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.position = current_user.todos.count
    @todo.user = current_user
    if @todo.save
      flash[:success] = "Added successfully"
      redirect_to todos_path(anchor: "todo-#{@todo.id}")
    else
      render 'todos/index'
    end

    authorize @todo
  end

  def check
    @todo = Todo.find(params[:todo_id])
    @todo.checked? ? @todo.unchecked! : @todo.checked!
    redirect_to todos_path(anchor: "todo-#{@todo.id}")

    authorize @todo
  end

  def up
    @todo = Todo.find(params[:todo_id])

    if @todo.position.positive?
      todo_above = Todo.find_by(position: @todo.position - 1)
      todo_above.position += 1
      todo_above.save
      @todo.position -= 1
      @todo.save
    end

    redirect_to todos_path(anchor: "todo-#{@todo.id}")
    authorize @todo
  end

  def down
    @todo = Todo.find(params[:todo_id])

    if @todo.position < (current_user.todos.count - 1)
      todo_below = Todo.find_by(position: @todo.position + 1)
      todo_below.position -= 1
      todo_below.save
      @todo.position += 1
      @todo.save
    end

    redirect_to todos_path(anchor: "todo-#{@todo.id}")
    authorize @todo
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :due_date)
  end
end
