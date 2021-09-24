defmodule Inmana.WelcomerTest do
  use ExUnit.Case

  alias Inmana.Welcomer

  describe "welcome/1" do
    test "when the user is special, returns a special message" do
      # setup
      params = %{"name" => "banana", "age" => "42"}
      # verification
      result = Welcomer.welcome(params)
      expected = {:ok, "Vc é especial, banana"}
      # assert
      assert result == expected
    end

    test "when the user is not special, returns a message" do
      # setup
      params = %{"name" => "rafael", "age" => "25"}
      # verification
      result = Welcomer.welcome(params)
      expected = {:ok, "Welcome rafael"}
      # assert
      assert result == expected
    end

    test "when the user is underage, returns a message" do
      # setup
      params = %{"name" => "rafael", "age" => "17"}
      # verification
      result = Welcomer.welcome(params)
      expected = {:error, "You shall not pass rafael"}
      # assert
      assert result == expected
    end
  end
end
