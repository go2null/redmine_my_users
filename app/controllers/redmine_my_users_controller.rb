class RedmineMyUsersController < ApplicationController::UsersController
	unloadable

	# override "layout 'admin' in UsersController
	layout 'base'

	# override "before_filter :require_admin' in UsersController
	before_filter :require_admin, :except => :index
	# override "before_filter :find_user' in UsersController
	before_filter :find_user, :only => [:show]

	def index
		sort_init 'login', 'asc'
		sort_update %w(login mail last_login_on)

    case params[:format]
    when 'xml', 'json'
      @offset, @limit = api_offset_and_limit
    else
      @limit = per_page_option
    end

		@status = params[:status] || 1

    scope = User.where("parent_id = ?", User.current.id).status(@status)
    scope = scope.like(params[:name]) if params[:name].present?
    scope = scope.in_group(params[:group_id]) if params[:group_id].present?

    @user_count = scope.count
    @user_pages = Paginator.new @user_count, @limit, params['page']
    @offset ||= @user_pages.offset
    @users =  scope.order(sort_clause).limit(@limit).offset(@offset).all

		unless @groups
			respond_to do |format|
				format.html {
					@groups = []
					@users.each { |u| @groups |= u.groups }
					@groups.sort
					render :layout => !request.xhr?
				}
				format.api
			end
		end
	end

end

