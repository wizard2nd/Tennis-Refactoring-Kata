require 'byebug'

class Player
  attr_reader :name, :points

  def initialize(name:, points: 0)
    @name = name
    @points = points
  end

  def add_point
    @points += 1
  end

  def advantage_against?(other_player)
    points >= 4 && lead_over(other_player) == 1
  end

  def wins_against?(other_player)
    points >= 4 && lead_over(other_player) >= 2
  end

  def points_same_as(other_player)
    lead_over(other_player).zero?
  end

  def advantage
    "Advantage #{name}"
  end

  def wins
    "Win for #{name}"
  end

  def lead_over(other_player)
    points - other_player.points
  end
end

class TennisGame1

  extend Forwardable

  POINTS_AS_WORDS = {
      0 => "Love",
      1 => "Fifteen",
      2 => "Thirty",
      3 => "Forty",
  }

  attr_reader :player1, :player2

  def initialize(player1_name, player2_name)
    @player1 = Player.new(name: player1_name)
    @player2 = Player.new(name: player2_name)
  end

  def won_point(player_name)
    player1.add_point if player1.name.eql? player_name
    player2.add_point if player2.name.eql? player_name
  end

  def score
    return 'Deuce' if deuce?
    return "#{points_of(player1)}-All" if player1.points_same_as player2
    return player1.advantage if player1.advantage_against?(player2)
    return player1.wins if player1.wins_against?(player2)
    return player2.advantage if player2.advantage_against?(player1)
    return player2.wins if player2.wins_against?(player1)

    "#{points_of(player1)}-#{points_of(player2)}"
  end

  def deuce?
    player1.points == player2.points && player1.points >= 3
  end

  def points_of(player)
    POINTS_AS_WORDS[player.points]
  end
end

class TennisGame2

  attr_reader :player1, :player2

  POINTS_AS_WORDS = { 0 => 'Love', 1 => 'Fifteen', 2 => 'Thirty', 3 => 'Forty' }

  def initialize(player1_name, player2_name)
    @player1 = Player.new(name: player1_name)
    @player2 = Player.new(name: player2_name)
  end

  def won_point(player_name)
    if player1.name == player_name
      player1.add_point
    else
      player2.add_point
    end
  end

  def score
    return 'Deuce' if deuce?
    return "#{points_for player1}-All" if equal_score
    return player1.advantage if player1.advantage_against?(player2)
    return player2.advantage if player2.advantage_against?(player1)
    return player1.wins if player1.wins_against?(player2)
    return player2.wins if player2.wins_against?(player1)

    "#{points_for player1}-#{points_for player2}"
  end

  def points_for(player)
    POINTS_AS_WORDS[player.points]
  end

  def deuce?
    player1.points == player2.points && player1.points > 2
  end

  def equal_score
    player1.points == player2.points && player1.points < 3
  end
end

class TennisGame3

  attr_reader :player1, :player2

  POINTS_TO_WORDS = %w(Love Fifteen Thirty Forty).freeze

  def initialize(player1_name, player2_name)
    @player1 = Player.new(name: player1_name)
    @player2 = Player.new(name: player2_name)
  end

  def won_point(player_name)
    if player_name == player1.name
      player1.add_point
    else
      player2.add_point
    end
  end

  def score
    return 'Deuce' if deuce?
    return "#{points_for(player1)}-All" if equal_points?
    return "Advantage #{score_points}" if advantage?
    return "#{points_for(player1)}-#{points_for(player2)}" if lead_or_equal_points?
    return "Win for #{score_points}"
  end

  def advantage?
    player1.points >= 3 && player2.points >= 3 && (player1.points - player2.points).abs == 1
  end

  def equal_points?
    player1.points == player2.points
  end

  def lead_or_equal_points?
    (player1.points <= 3 && player2.points <= 3) && (player1.points + player2.points < 6)
  end

  def deuce?
    player1.points == player2.points && player1.points >= 3
  end

  private

  def score_points
    player1.points > player2.points ? player1.name : player2.name
  end

  def points_for(player)
    POINTS_TO_WORDS[player.points]
  end
end
