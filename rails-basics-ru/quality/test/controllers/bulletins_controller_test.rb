# frozen_string_literal: true

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  def test_opens_all_bulletins_page
    get bulletins_url
    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  def test_opens_bulletin_page_with_fixtures
    bulletin = bulletins(:news1)
    get bulletin_url(bulletin)
    assert_response :success
    assert_select 'h1', 'Bulletin page'
    assert_select 'h2', 'news 1'
  end
end
