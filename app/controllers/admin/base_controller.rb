class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!
  layout "admin"
  default_form_builder AdminUi::FormBuilder
end
