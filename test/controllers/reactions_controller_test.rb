require 'test_helper'

class ReactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reaction = reactions(:one)
  end

  test "should get index" do
    get reactions_url, as: :json
    assert_response :success
  end

  test "should create reaction" do
    assert_difference('Reaction.count') do
      post reactions_url, params: { reaction: { comment_id: @reaction.comment_id, type: @reaction.type, user_id: @reaction.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show reaction" do
    get reaction_url(@reaction), as: :json
    assert_response :success
  end

  test "should update reaction" do
    patch reaction_url(@reaction), params: { reaction: { comment_id: @reaction.comment_id, type: @reaction.type, user_id: @reaction.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy reaction" do
    assert_difference('Reaction.count', -1) do
      delete reaction_url(@reaction), as: :json
    end

    assert_response 204
  end
end
