module ApplicationHelper
  def sanitize(untrusted_string)
    cleaned = ""
    untrusted_string.force_encoding Encoding::BINARY
    untrusted_string.codepoints.each do |c|
      cleaned += c.chr('UTF-8')
    end
    cleaned
  end
end
