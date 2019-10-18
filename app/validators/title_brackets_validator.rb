class TitleBracketsValidator < ActiveModel::EachValidator
  OPEN_BRACKETS              = ["[", "{", "("].freeze
  CLOSED_BRACKETS            = ["]", "}", ")"].freeze
  OPPOSITE_BRACKETS_HASH_MAP = {
    "(" => ")",
    ")" => "(",
    "[" => "]",
    "]" => "[",
    "{" => "}",
    "}" => "{"
  }.freeze

  def validate_each(record, attribute, value)
    return if value.blank?

    unless all_brackets_valid?(value)
      record.errors[attribute] << (options[:message] || "has brackets used incorrectly.")
    end
  end

  private

  def all_brackets_valid?(value)
    occurances_hash_map = create_occurances_hash_map

    value.each_char.with_index do |char, index|
      return false if CLOSED_BRACKETS.include?(char) &&
          closed_bracket_before_open?(occurances_hash_map, char)
      return false if OPEN_BRACKETS.include?(char) &&
          empty_bracket_occurance?(char, value[index + 1])

      occurances_hash_map[char] += 1 if all_brackets.include?(char)
    end

    brackets_even_occurance?(occurances_hash_map)
  end

  def empty_bracket_occurance?(char, next_char)
    closed_bracket = OPPOSITE_BRACKETS_HASH_MAP[char]

    next_char == closed_bracket
  end

  def closed_bracket_before_open?(occurances_hash_map, char)
    open_bracket = OPPOSITE_BRACKETS_HASH_MAP[char]

    occurances_hash_map[open_bracket] <= occurances_hash_map[char]
  end

  def brackets_even_occurance?(occurances_hash_map)
    OPEN_BRACKETS.all? do |open_bracket|
      closed_bracket = OPPOSITE_BRACKETS_HASH_MAP[open_bracket]

      occurances_hash_map[open_bracket] == occurances_hash_map[closed_bracket]
    end
  end

  def create_occurances_hash_map
    all_brackets.map { |bracket| [bracket, 0] }.to_h
  end

  def all_brackets
    @all_brackets ||= OPEN_BRACKETS + CLOSED_BRACKETS
  end
end
