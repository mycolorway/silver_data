require 'test_helper'

class FormFieldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_field = form_fields(:one)
  end

  test "should get index" do
    get form_fields_url
    assert_response :success
  end

  test "should get new" do
    get new_form_field_url
    assert_response :success
  end

  test "should create form_field" do
    assert_difference('FormField.count') do
      post form_fields_url, params: { form_field: { data_type: @form_field.data_type, default_value: @form_field.default_value, form_group_id: @form_field.form_group_id, hint: @form_field.hint, name: @form_field.name, title: @form_field.title, validation_options: @form_field.validation_options } }
    end

    assert_redirected_to form_field_url(FormField.last)
  end

  test "should show form_field" do
    get form_field_url(@form_field)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_field_url(@form_field)
    assert_response :success
  end

  test "should update form_field" do
    patch form_field_url(@form_field), params: { form_field: { data_type: @form_field.data_type, default_value: @form_field.default_value, form_group_id: @form_field.form_group_id, hint: @form_field.hint, name: @form_field.name, title: @form_field.title, validation_options: @form_field.validation_options } }
    assert_redirected_to form_field_url(@form_field)
  end

  test "should destroy form_field" do
    assert_difference('FormField.count', -1) do
      delete form_field_url(@form_field)
    end

    assert_redirected_to form_fields_url
  end
end
