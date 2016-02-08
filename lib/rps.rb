# Determine a game's result.
#
# p1_weapon - The first player's weapon String.
# p2_weapon - The other player's weapon String.
#
# Examples
#
#   rps_justice('rock', 'paper')
#   # => 'Player 2 wins!'
# 
#   rps_justice('paper', 'paper')
#   # => 'Tie game!'
#


# Returns the result String.
def rps_justice(p1, p2)

	if (p1 == "scissors" && p2 == "paper") || (p1 == "rock" && p2 == "scissors") || (p1 == "paper" && p2 == "rock")
	 	return "PLAYER ONE WINS!"
	  
	elsif (p2 == "scissors" && p1 == "paper") || (p2 == "rock" && p1 == "scissors") || (p2 == "paper" && p1 == "rock")
	 	return "PLAYER TWO WINS!"

	else
		return "Tie game. No one wins."
	end
end
