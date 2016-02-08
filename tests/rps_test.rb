require 'test_helper'

class RockPaperScissorsTest < Minitest::Test
  # These lines of code should not be edited. They add necessary
  # functionality for running our "acceptance tests".
  def app
    MyApp
  end

  # The actual tests go below this comment.
	def test_paper_beats_rock
	  get "/rock/paper"
	  assert last_response.ok?

	  assert_includes last_response.body, "PLAYER TWO WINS"
	end

	def test_paper_beats_scissors
	  get "/scissors/paper"
	  assert last_response.ok?

	  assert_includes last_response.body, "PLAYER ONE WINS"
	end

	def test_tie
	  get "/paper/paper"
	  assert last_response.ok?

	  assert_includes last_response.body, "Tie game."
	end

	def test_p2_links_if_p1_chooses_scissors
 	 get "/scissors"
	  assert last_response.ok?

	  assert_includes last_response.body, '<a href="/scissors/rock">'
	  assert_includes last_response.body, '<a href="/scissors/paper">'
	  assert_includes last_response.body, '<a href="/scissors/scissors">'
	end
end






