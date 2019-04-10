ExUnit.configure(exclude: [skip: true])
ExUnit.start()
# Not sure I need this?
HTTPoison.start()

# To run the tests needing authorization, without using VCR,
# follow the auth steps in the readme, and put the code you get back into the function below.
# Unsplash.OAuth.authorize! code: "code_goes_here"

defmodule PathHelpers do
  def fixture_path do
    Path.expand("../fixture", __DIR__)
  end

  def fixture_path(file_path) do
    Path.join(fixture_path(), file_path)
  end
end
