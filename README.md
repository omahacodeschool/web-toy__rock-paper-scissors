# Toy - Web

## String Segmentation

The goal of this assignment is to practice more complex logic-only web application development.

When it's complete, you will be able to play a single game of Rock-Paper-Scissors through the website.

The **Assignment Details** section below goes into more detail about what this application will look like.

### Getting Started

#### Installation

First, fork this repository, if you haven't already.

Then clone your fork on to your local development machine:

```zsh
cd ~/Code
git clone url_for_your_copy_of_this_assignment
```

(Note: You'll need to replace `url_for_your_copy_of_this_assignment` with the actual SSH URL for your repository, which looks something like `git@github.com:sumeetjain/web-toy__some-assignment.git`.)

That will create a folder named for the assignment in **~/Code**, and it will download the files from the repository into that folder.

Next, `cd` into that newly created folder, and run the setup script:

```zsh
cd the-newly-created-folder
bin/setup
```

(Note: You'll need to replace `the-newly-created-folder` with the actual name of the folder for your assignment.)

You won't need to run the setup script for this assignment again.

If the setup script does not return any failures or errors, you're ready to work on the assignment. Open the project folder in your code editor, and begin.

### Assignment Details

When completed, the following procedure should work:

1. Go to http://localhost:9292/
2. There, you'll see a message saying, "Player 1, choose your weapon."
3. You'll also see three links:
  - "Rock", which is a link to `"/rock"`.
  - "Paper", which is a link to `"/paper"`.
  - "Scissors", which is a link to `"/scissors"`.
4. Regardless of which weapon was chosen, the page that is shown now should have a message saying, "Player 2, choose your weapon."
5. And also three links:
  - "Rock", which is a link to either `"/rock/rock"`, `"/paper/rock"`, or `"/scissors/rock"`.
  - "Paper", which is a link to either `"/rock/paper"`, `"/paper/paper"`, or `"/scissors/paper"`.
  - "Scissors", which is a link to either `"/rock/scissors"`, `"/paper/scissors"`, or `"/scissors/scissors"`.
6. Player 2 clicks one of those links. Depending on the one they click, the content of the next page is either:
  - Player 1 wins!
  - Player 2 wins!
  - Tie game :/
7. Users can then click a link that takes them back to the homepage to try again.

#### How To Begin

There are a number of ways to begin this assignment. Let's talk about the _end_  first though.

##### The End

In the end, you will definitely have a controller action like this:

```ruby
MyApp.get "/:p1_weapon/:p2_weapon" do
  @game_result = rps_justice(params[:p1_weapon], params[:p2_weapon])

  erb :"result"
end
```

Of course, you'll need a working `rps_justice` method. More on that [further down](#the-rock-paper-scissors-algorithm).

But assuming that works, your controller action would be quite nifty! Remember the 3 links that Player 2 would see when it's their turn?

- "Rock", which is a link to either `"/rock/rock"`, `"/paper/rock"`, or `"/scissors/rock"`.
- "Paper", which is a link to either `"/rock/paper"`, `"/paper/paper"`, or `"/scissors/paper"`.
- "Scissors", which is a link to either `"/rock/scissors"`, `"/paper/scissors"`, or `"/scissors/scissors"`.

If Player 1 chose "rock", and Player 2 clicks the link to go to "/rock/scissors", then this controller action here will be triggered. Because the request path matches!

```ruby
#         "/rock      /scissors  " <-- See? A match!
MyApp.get "/:p1_weapon/:p2_weapon" do
# ...
```

Since that controller action's given path matches the request's path, the controller action will execute:

```ruby
#         "/rock      /scissors  " <-- See? A match!
MyApp.get "/:p1_weapon/:p2_weapon" do
  # So params[:p1_weapon] is "rock" and
  #    params[:p2_weapon] is "scissors"

  @game_result = rps_justice(params[:p1_weapon], params[:p2_weapon])

  # So if the rps_justice method works, it should return something
  # like "Player 1 wins!" And that String is stored in @game_result.

  erb :"result"
end
```

With `@game_result` set to some String containing the result of the game, the ERB file located at **views/result.erb** would be able to display that result.

###### The Ending View

```erb
Game over! Here's the result:

<%= @game_result %>

<a href="/">Play again?</a>
```

So that's how this will all end. But first...

##### Player 2's Weapon Choice

You need to make sure that Player 2 is presented with valid links. Otherwise, the final controller action (above) won't have correct inputs.

I've outlined the links you need to show Player 2 here:

Player 1 chose... | So they clicked a link to... | Thus, Player 2 sees...
----------------- | ---------------------------- | ---------------------------
rock              | `/rock`                      | Rock (linked to `/rock/rock`)<br>Paper (linked to `/rock/paper`)<br>Scissors (linked to `/rock/scissors`)
paper              | `/paper`                      | Rock (linked to `/paper/rock`)<br>Paper (linked to `/paper/paper`)<br>Scissors (linked to `/paper/scissors`)
scissors              | `/scissors`                      | Rock (linked to `/scissors/rock`)<br>Paper (linked to `/scissors/paper`)<br>Scissors (linked to `/scissors/scissors`)

So Player 2 will see links for the weapons regardless. But the `href` (the _destination_) which those links go to will be different, depending on what Player 1 chose for their weapon.

##### Player 1's Weapon Choice

And irrespective of all of this, the _homepage_, where Player 1 chooses their weapon, shows three links:

```html
<a href="/rock">Rock</a>
<a href="/paper">Paper</a>
<a href="/scissors">Scissors</a>
```

Player 1's weapon choice is not affected by anything before it, so it's a good place to start--right after you've written some tests.

##### Tests

Since we know how this will all end, you can write a test right off the bat:

```ruby
def test_paper_beats_rock
  get "/rock/paper"
  assert last_response.ok?

  assert_includes last_response.body, "Player 2 wins"
end
```

And you could write a couple more tests like that.

You can also test the page for Player 2's weapon choice:

```ruby
def test_p2_links_if_p1_chooses_scissors
  get "/scissors"
  assert last_response.ok?

  assert_includes last_response.body, '<a href="/scissors/rock">'
  assert_includes last_response.body, '<a href="/scissors/paper">'
  assert_includes last_response.body, '<a href="/scissors/scissors">'
end
```

And again, you can write a couple similar tests (for the other possibilities).

You do not need to write any other kinds of tests.

#### The Rock-Paper-Scissors Algorithm

Yes, you've written RPS. But I strongly encourage you to **rewrite** it just for this assignment. Don't try to just drop your existing code into this Sinatra project. Two reasons:

1. Most of you build your RPS games to play a set of some kind--not just one game. This web version of the game is much simpler than that. Just one game!
2. It might be hard for some of you to extract just the game's logic, since your code has a lot of `puts` and `gets` statements in it (And those aren't useful to us on a Web medium).

Certainly consult your code--no need to do all the thinking again. But don't expect to be able to drop your files into **lib/** and have it work. Instead, write the body of the `rps_justice` method that I've started for you. (It's in **lib/rps.rb** already.)

##### Resources

You might need to read this tutorial about ERB tags: https://learn.co/lessons/sinatra-using-erb