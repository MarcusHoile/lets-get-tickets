class PlansController < ApplicationController
  before_filter :check_plan_status, only: [:show]
  before_filter :set_view_path, only: [:show]
  before_filter :set_demo_end_date, only: [:demo_open]
  helper_method :current_plan

  def index
    @plans = ::Query::User::Plans.all(current_user)
  end

  def show
    @plan = ::Presenter::Plan.new(current_plan, current_user, view_context)
  end

  def edit
    @plan = ::PlanForm.new(current_plan)
  end

  def create
    ::Hopscotch::Runner.call_each(
      -> { @plan = ::Service::Plan::Create.call(current_user, plan, params[:plan]) },
      -> { ::Service::Plan::Invite::Create.call(invite, plan.model, current_user, 'going')},
      success: -> { redirect_to plan_path(@plan) },
      failure: -> (msg) { render action: 'new' }
    )
  end


  def update
    ::Hopscotch::Runner.call_each(
      -> { ::Service::Plan::UpdateRecord.call(current_plan, params[:plan]) },
      -> { ::Service::Plan::Guests::SendNotifications.call(current_plan, notice: 'notify_guests')},
      success: -> { redirect_to plan_path(current_plan) },
      failure: -> (msg) { render action: 'edit' }
    )
  end


  def destroy
    # there is no links to destroy atm
    current_plan.destroy
    redirect_to plans_url
  end

  def demo_closed
    @plan = ::Presenter::Plan.new(demo_plan_closed, demo_user, view_context)
    set_demo_views
  end

  def demo_open
    @plan = ::Presenter::Plan.new(demo_plan_open, demo_user, view_context)
    set_demo_views
  end

  private

  def plan
    @plan ||= ::PlanForm.new(Plan.new)
  end
  helper_method :plan

  def invite
    @invite ||= ::InviteForm.new(Invite.new)
  end
  helper_method :invite

  def demo_plan_closed
    ::Query::Plan::Demo.closed
  end

  def demo_plan_open
    ::Query::Plan::Demo.open
  end

  def demo_user
    User.where(demo: true).first
  end

  def user_type
    (current_user == current_plan.host) ? "planner" : "guest"
  end

  def set_view_path
    prepend_view_path("#{Rails.root}/app/views/#{user_type}")
  end

  def set_demo_views
    prepend_view_path("#{Rails.root}/app/views/planner")
    render template: 'planner/plans/show'
  end

  def set_demo_end_date
    demo_plan_open.update(deadline: Time.now + 3.days)
  end

  def current_plan
    @current_plan ||= Plan.find(params[:id])
  end

  def check_plan_status
    current_plan.check_status
  end

end
