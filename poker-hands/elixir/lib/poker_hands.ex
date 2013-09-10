defmodule Poker.Hands do

  def rank(cards) when is_list(cards) do
    sort(cards) |> determine_hand_type
  end

  defp sort(cards) do

  end

  defp determine_hand_type(cards) do
    case straight_flush?(cards) do :straight_flush end
    case four_of_a_kind?(cards) do :four_of_a_kind end
    case full_house?(cards) do :full_house end
    case is_flush?(cards) do :flush end
  end
end
