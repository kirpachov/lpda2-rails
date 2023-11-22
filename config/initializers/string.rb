# frozen_string_literal: true

# Extending the String class to add some methods.
class String
  def valid_json?
    JSON.parse(self)
    true
  rescue JSON::ParserError
    false
  end

  def valid_email?
    !!(self =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
  end

  def intersection(other)
    str = self.dup
    other.split(//).inject(0) do |sum, char|
      sum += 1 if str.sub!(char,'')
      sum
    end
  end
end
