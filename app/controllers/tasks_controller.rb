class TasksController < ApplicationController
  before_filter :authenticate_user!, except: [:browse, :public_show]
  before_filter :find_user
  before_filter :find_task, only: [:edit, :update, :destroy]
  before_filter :ensure_proper_user, except: [:browse, :clone, :public_show]
  # GET /tasks
  # GET /tasks.json
  def index
    #@tasks = Task.all
    @tasks = @user.tasks.all(:order => 'updated_at DESC')
    #@tasks = @user.tasks.all(:order => 'objectives.updated_at')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # Shows all public tasks by all users
  def browse
    @tasks = Task.public.all(:order => 'updated_at DESC')
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    #@task = @user.task.find(params[:id])
    #redirect_to task_objectives_path(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    #@task = Task.new
    @task = current_user.tasks.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    #@task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    #@task = Task.new(params[:task])
    @task = current_user.tasks.new(params[:task])
    @task.author = current_user.profile_name
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path(current_user), notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    #@task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_path(current_user), notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    #@task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_path(current_user) }
      format.json { head :no_content }
    end
  end

  def clone
    # First we find the task so we can use the user_id for validation
    @task = Task.find(params[:task_id])
    # Then we check whether the user is trying to clone his own task, if not we proceed.
    if @task.user_id != current_user.id
      # Using Deep_cloneable to clone both a Task and all associated Objectives.
      # Note that all associated objectives are deleted upon deleting the task.
      @task = @task.dup :include => :objectives
      # Changes the user_id of the cloned task and assignes it to the current user,
      # so that it appears in the view of the current_user.
      @task.user_id = current_user.id
      # Sets completed to false on each objective in the cloned task
      @task.objectives.each do |objective|
        objective.completed = false
        objective.save
      end
      # Makes it private by default so it does not appear in browse page
      @task.public = false
      # Display the flash messages upon success
      if @task.save
        flash[:notice] = 'Task was successfully cloned. Have fun!'
        redirect_to(tasks_path(current_user))
      else
        flash[:error] = 'Sorry, the task could not be cloned. You can try another one!'
        redirect_to(browse_path)
      end
    # If the user is trying to clone his own task displays a message.
    else
      flash[:error] = 'You cannot clone your own task'
      redirect_to(browse_path)
    end
  end

  def public
    @task = @user.tasks.find(params[:task_id])
    @task.public = true
    @task.save
    redirect_to tasks_path(current_user)
  end

  def public_show
    @task = Task.public.find(params[:task_id])
    if @task.blank?
      redirect_to browse_path
    end
  end

  def share_to_facebook
    @task = @user.tasks.find(params[:task_id])
    if @user.authentications.where(:provider == 'facebook').exists?
      current_user.facebook.put_wall_post(@task.title + ", live on www.ubjective.com" + public_show_path(@task.id) + " - What is your ubjective?")
      redirect_to tasks_path(current_user), notice: 'Task was successfully Shared on your Stream.'
    else
    redirect_to tasks_path(current_user), notice: 'You need to sign in with Facebook first.'
    end
  end

  def private
    @task = @user.tasks.find(params[:task_id])
    @task.public = false
    @task.save
    redirect_to tasks_path(current_user)
  end

  def url_options
    { profile_name: params[:profile_name] }.merge(super)
  end

  private

  def ensure_proper_user
    if current_user != @user
      flash[:error] = "You don't have premission to do that."
      redirect_to root_path
    end
  end

  def find_user
    @user = User.find_by_profile_name(params[:profile_name])
  end

  def find_task
    @task = current_user.tasks.find(params[:id])
  end

end













