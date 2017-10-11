require 'test_helper'

class FunnelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @funnel = funnels(:one)
  end

  test "should get index" do
    get funnels_url
    assert_response :success
  end

  test "should get new" do
    get new_funnel_url
    assert_response :success
  end

  test "should create funnel" do
    assert_difference('Funnel.count') do
      post funnels_url, params: { funnel: { down_product_id: @funnel.down_product_id, is_active: @funnel.is_active, name: @funnel.name, shop_id: @funnel.shop_id, up_product_id: @funnel.up_product_id } }
    end

    assert_redirected_to funnel_url(Funnel.last)
  end

  test "should show funnel" do
    get funnel_url(@funnel)
    assert_response :success
  end

  test "should get edit" do
    get edit_funnel_url(@funnel)
    assert_response :success
  end

  test "should update funnel" do
    patch funnel_url(@funnel), params: { funnel: { down_product_id: @funnel.down_product_id, is_active: @funnel.is_active, name: @funnel.name, shop_id: @funnel.shop_id, up_product_id: @funnel.up_product_id } }
    assert_redirected_to funnel_url(@funnel)
  end

  test "should destroy funnel" do
    assert_difference('Funnel.count', -1) do
      delete funnel_url(@funnel)
    end

    assert_redirected_to funnels_url
  end
end
