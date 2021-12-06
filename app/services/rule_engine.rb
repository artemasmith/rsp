class InvalidRules < StandardError; end
class ThrowParsingError < StandardError; end
class RuleEngine
  
  # @rules = a->b;b->c;c->a
  def initialize(rules = nil)
    rules = rules || ENV['throws'] || SRP_CONFIG['throws']
    analyze_rules(rules)
  end

  def parse(throw1, throw2)
    return 'tie' if throw1 == throw2
    raise ThrowParsingError if !possible_throws.include?(throw1) || !possible_throws.include?(throw2)

    result = if parsed_rules[throw1] == throw2
               'win'
             elsif parsed_rules[throw2] == throw1
               'loose'
             end
    result
  end

  def possible_throws
    parsed_rules.keys
  end

  private

  attr_reader :parsed_rules

  def analyze_rules(unparsed)
    raise InvalidRules if unparsed.blank? || !unparsed.include?('->') || !unparsed.include?(';')
    @parsed_rules = {}

    unparsed.split(';').each do |rule|
      winner, looser = rule.split('->')
      @parsed_rules[winner] = looser
    end
  rescue => e
    raise InvalidRules.new("Can't parse rules #{e.message}")
  end
end
