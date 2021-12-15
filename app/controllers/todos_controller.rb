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

    if @todo.save
      flash[:success] = "Updated successfully"
      redirect_to todos_path(anchor: "todo-#{@todo.id}")
    else
      flash[:alert] = "An error has occured, please try again."
      render 'todos/index'
    end

    authorize @todo
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :due_date)
  end
end
