module ApplicationHelper
  PAGEJS_ALIASES = { 'create' => 'new', 'update' => 'edit' }.freeze

  # Public: The data value for PageJS.
  #
  # It uses the same convetion for Rails routes controller#action as identifier
  # for javascript page initialization. But accepts options to overwrite them.
  #
  # Check page.js and application.js for further info.
  #
  # Examples
  #
  #  # When the `PagesController#show` action is rendering a view.
  #  pagejs # => 'pages/show'
  #
  #  # When the `PagesController#create` action is rendering the `new` view
  #  #  when the validation fails.
  #  pagejs # => 'pages/new'
  #
  # Returns a String.
  def pagejs
    controller = params[:controller]
    view = PAGEJS_ALIASES[pagejs_action] || pagejs_action
    "#{controller}##{view}"
  end

  # Public: The page.js action.
  #
  # As the OrdersController is used in all products and all steps, we use a compound
  # action with the given insurance type and the current step.
  #
  # Examples
  #
  #   Suppose the URL:
  #     /home/order/coverages_selection/edit
  #
  #   The page.js action will be:
  #     'home_coverages_selection'
  #
  # Returns a String.
  def pagejs_action
    if params[:controller] == 'orders'
      "#{params[:insurance_type]}_#{params[:current_step]}"
    else
      params[:action]
    end
  end
end
