require 'byebug'

class TennisGame1
  POINTS_TO_WORDS = {
      0 => "Love",
      1 => "Fifteen",
      2 => "Thirty",
      3 => "Forty",
  }

  attr_reader :player_1_points, :player_1_name, :player_2_points, :player_2_name

  def initialize(player_1_name, player_2_name)
    @player_1_name = player_1_name
    @player_1_points = 0
    @player_2_name = player_2_name
    @player_2_points = 0
  end

  def won_point(player_name)
    case player_name
    when player_1_name
      @player_1_points += 1
    when player_2_name
      @player_2_points += 1
    end
  end

  def score
    return 'Deuce' if deuce?
    return equal_score if player_1_points == player_2_points
    return win_or_advantage if win_or_advantage?
    "#{POINTS_TO_WORDS[player_1_points]}-#{POINTS_TO_WORDS[player_2_points]}"
  end

  def equal_score
    "#{POINTS_TO_WORDS[player_1_points]}-All"
  end

  def deuce?
    player_1_points == player_2_points && player_1_points >= 3
  end

  def win_or_advantage?
    player_1_points >= 4 || player_2_points >= 4
  end

  def win_or_advantage
    lead = player_1_points - player_2_points
    if lead == 1
      advantage(player_1_name)
    elsif lead == -1
      advantage(player_2_name)
    elsif lead >= 2
      wins(player_1_name)
    else
      wins(player_2_name)
    end
  end

  def wins(player_name)
    "Win for #{player_name}"
  end

  def advantage(player_name)
    "Advantage #{player_name}"
  end
end

class TennisGame2

  attr_reader :player1_name, :player2_name

  def initialize(player1Name, player2Name)
    @player1_name = player1Name
    @player2_name = player2Name
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
    if equal_score
      result = case @p1points
               when 0
                 'Love'
               when 1
                 'Fifteen'
               when 2
                 'Thirty'
               end
      return "#{result}-All"
    end

    return 'Deuce' if deuce?

    p2res = ""
    if player_one_leads?

      p1res = case @p1points
              when 1
                'Fifteen'
              when 2
                'Thirty'
              when 3
                'Forty'
              else
                ''
              end

      p2res = "Love"
      result = "#{p1res}-Love"
    end

    if (@p2points > 0 and @p1points==0)
      if (@p2points==1)
        p2res = "Fifteen"
      end
      if (@p2points==2)
        p2res = "Thirty"
      end
      if (@p2points==3)
        p2res = "Forty"
      end
      
      p1res = "Love"
      result = p1res + "-" + p2res
    end
    
    if (@p1points>@p2points and @p1points < 4)
      if (@p1points==2)
        p1res="Thirty"
      end
      if (@p1points==3)
        p1res="Forty"
      end
      if (@p2points==1)
        p2res="Fifteen"
      end
      if (@p2points==2)
        p2res="Thirty"
      end
      result = p1res + "-" + p2res
    end
    if (@p2points>@p1points and @p2points < 4)
      if (@p2points==2)
        p2res="Thirty"
      end
      if (@p2points==3)
        p2res="Forty"
      end
      if (@p1points==1)
        p1res="Fifteen"
      end
      if (@p1points==2)
        p1res="Thirty"
      end
      result = p1res + "-" + p2res
    end
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

  def setp1Score(number)
    (0..number).each do |i|
        p1Score()
    end
  end

  def setp2Score(number)
    (0..number).each do |i|
      p2Score()
    end
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
