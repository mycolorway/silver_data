require 'test_helper'

class FormGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_group = form_groups(:one)
  end

  test "should get index" do
    get form_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_form_group_url
    assert_response :success
  end

  test "should create form_group" do
    assert_difference('FormGroup.count') do
      post form_groups_url, params: { form_group: { form_field_id: @form_group.form_field_id, form_group_id: @form_group.form_group_id, form_id: @form_group.form_id, name: @form_group.name, options: @form_group.options, type: @form_group.type } }
    end

    assert_redirected_to form_group_url(FormGroup.last)
  end

  test "should show form_group" do
    get form_group_url(@form_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_group_url(@form_group)
    assert_response :success
  end

  test "should update form_group" do
    patch form_group_url(@form_group), params: { form_group: { form_field_id: @form_group.form_field_id, form_group_id: @form_group.form_group_id, form_id: @form_group.form_id, name: @form_group.name, options: @form_group.options, type: @form_group.type } }
    assert_redirected_to form_group_url(@form_group)
  end

  test "should destroy form_group" do
    assert_difference('FormGroup.count', -1) do
      delete form_group_url(@form_group)
    end

    assert_redirected_to form_groups_url
  end
end
