# frozen_string_literal: true

# Extending the String class to add some methods.
class String
  def valid_json?
    JSON.parse(self)
    true
  rescue JSON::ParserError
    false
  end

  def true?
    downcase.in?(%w[true 1 yes t])
  end

  def false?
    downcase.in?(%w[false 0 no f])
  end

  def valid_email?
    !!(self =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
  end

  def to_duration
    call = StringToDuration.run(string: self)

    Rails.logger.debug { "StringToDuration: #{call.errors.full_messages}" } unless call.valid?

    call.result
  end

  def intersection(other)
    str = dup
    other.split("").inject(0) do |sum, char|
      sum += 1 if str.sub!(char, "")
      sum
    end
  end

  # Convert a language code to a ISO 639-2 code.
  def lang_to_iso639_2
    {
      "it" => "ita",
      "en" => "eng",
      "de" => "deu",
      "fr" => "fra",
      "es" => "spa",
      "pt" => "por",
    }[downcase]
  end
end
