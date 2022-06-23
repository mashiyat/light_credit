# LightCredit

This version mostly focued on the happy path of the application for time constraints!
Have many validation problems! Need both unit test and integration tests!

To start the application server:

  * Install dependencies with `mix deps.get`
  * Update config/dev.ex with postgresql credencials
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  * Visit http://localhost:4000/


## Generator Used
mix phx.new light_credit --binary-id
mix phx.gen.live CreditEvaluation Question questions category step_number:integer question_text points:integer

## tOdOS
1. Add unit test and integration tests.
2. Add validations in all pages.
3. The credit evaluation questions are loaded from seed. In future, admin dashboard can be built to add/delete/edit these questions
   to control the flow of the questions and their weight.