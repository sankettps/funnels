require 'test_helper'

class AdvanceSettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advance_setting = advance_settings(:one)
  end

  test "should get index" do
    get advance_settings_url
    assert_response :success
  end

  test "should get new" do
    get new_advance_setting_url
    assert_response :success
  end

  test "should create advance_setting" do
    assert_difference('AdvanceSetting.count') do
      post advance_settings_url, params: { advance_setting: { downsell_css: @advance_setting.downsell_css, shop_id: @advance_setting.shop_id, upsell_css: @advance_setting.upsell_css } }
    end

    assert_redirected_to advance_setting_url(AdvanceSetting.last)
  end

  test "should show advance_setting" do
    get advance_setting_url(@advance_setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_advance_setting_url(@advance_setting)
    assert_response :success
  end

  test "should update advance_setting" do
    patch advance_setting_url(@advance_setting), params: { advance_setting: { downsell_css: @advance_setting.downsell_css, shop_id: @advance_setting.shop_id, upsell_css: @advance_setting.upsell_css } }
    assert_redirected_to advance_setting_url(@advance_setting)
  end

  test "should destroy advance_setting" do
    assert_difference('AdvanceSetting.count', -1) do
      delete advance_setting_url(@advance_setting)
    end

    assert_redirected_to advance_settings_url
  end
end
