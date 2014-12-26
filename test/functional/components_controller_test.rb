require 'test_helper'

class LooseComponentsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  def setup
    @controller = ComponentsController.new
  end
end
