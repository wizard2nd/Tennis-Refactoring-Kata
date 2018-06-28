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

  private

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

  attr_reader :player1_name, :player2_name, :player1, :player2

  POINTS_AS_WORDS = { 0 => 'Love', 1 => 'Fifteen', 2 => 'Thirty', 3 => 'Forty' }

  def initialize(player1_name, player2_name)
    @player1 = Player.new(name: player1_name)
    @player2 = Player.new(name: player2_name)
    @player1_name = player1_name
    @player2_name = player2_name
    @p1points = 0
    @p2points = 0
  end
      
  def won_point(playerName)
    if playerName == player1_name
      p1Score()
    else
      p2Score()
    end
  end

  def score

    return "#{POINTS_AS_WORDS[@p1points]}-All" if equal_score

    return 'Deuce' if deuce?

    p2res = "Love" if @p2points == 0
    p1res = "Love" if @p1points == 0


    if @p1points > 0
      p1res = POINTS_AS_WORDS[@p1points]
      result = "#{p1res}-#{p2res}"
    end

    if @p2points > 0
      p2res = POINTS_AS_WORDS[@p2points]
      result = "#{p1res}-#{p2res}"
    end

    result = "#{POINTS_AS_WORDS[@p1points]}-#{POINTS_AS_WORDS[@p2points]}" if (@p1points>@p2points and @p1points < 4)

    result = "#{POINTS_AS_WORDS[@p1points]}-#{POINTS_AS_WORDS[@p2points]}" if (@p2points>@p1points and @p2points < 4)

    if (@p1points > @p2points and @p2points >= 3)
      result = "Advantage " + player1_name
    end
    if (@p2points > @p1points and @p1points >= 3)
      result = "Advantage " + player2_name
    end
    if (@p1points>=4 and @p2points>=0 and (@p1points-@p2points)>=2)
      result = "Win for " + player1_name
    end
    if (@p2points>=4 and @p1points>=0 and (@p2points-@p1points)>=2)
      result = "Win for " + player2_name
    end
    result
  end

  def player_one_leads?
    @p1points > 0 && @p2points == 0
  end

  def deuce?
    @p1points == @p2points && @p1points > 2
  end

  def equal_score
    @p1points == @p2points && @p1points < 3
  end

  def p1Score
    @p1points +=1
  end
  
  def p2Score
    @p2points +=1
  end
end

class TennisGame3
  def initialize(player1Name, player2Name)
    @p1N = player1Name
    @p2N = player2Name
    @p1 = 0
    @p2 = 0
  end
      
  def won_point(n)
    if n == @p1N
        @p1 += 1
    else
        @p2 += 1
    end
  end
  
  def score
    if (@p1 < 4 and @p2 < 4) and (@p1 + @p2 < 6)
      p = ["Love", "Fifteen", "Thirty", "Forty"]
      s = p[@p1]
      @p1 == @p2 ? s + "-All" : s + "-" + p[@p2]
    else
      if (@p1 == @p2)
        "Deuce"
      else
        s = @p1 > @p2 ? @p1N : @p2N
        (@p1-@p2)*(@p1-@p2) == 1 ? "Advantage " + s : "Win for " + s
      end
    end
  end
end
