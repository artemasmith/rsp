class GameService
  def initialize(rule_engine)
    @rule_engine = rule_engine
  end

  def call(user_throw)
    service_throw = get_service_throw
    compare_throws(user_throw, service_throw)
  end

  private

  attr_reader :rule_engine

  def get_service_throw
    result = ApiClient.new.get_throw
    unless result
      get_random_throw
    end
  end

  def compare_throws(t1, t2)
    rule_engine.parse(t1, t2)
  end

  def get_random_throw
    rule_engine.possible_throws.sample
  end
end
