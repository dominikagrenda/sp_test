require "terminal-table"

class LogParser
  def initialize(log)
    @log = log
    @entries = Hash.new { |h, k| h[k] = [] }
  end

  def parse
    return entries if entries.any?

    File.open(log).each do |line|
      page, ip = line.split(/\s+/)
      entries[page] << ip
    end

    entries
  end

  def frequency
    frequency = count(unique: false).sort_by{|k,v| v}.reverse.to_h

    pretty_output(frequency, "visits")
    frequency
  end

  def frequency_unique
    frequency_unique = count(unique: true).sort_by{|k,v| v}.reverse.to_h

    pretty_output(frequency_unique, "unique views")
    frequency_unique
  end

  private

  attr_reader :entries, :log

  def count(unique:)
    entries.each_with_object({}) do |(key, value), records|
      records[key] = unique ? value.uniq.size : value.size
    end
  end

  def pretty_output(records, type)
    table = Terminal::Table.new do |t|
      t << ["N", "Url", "Count"]
      t.add_separator
      records.each.with_index(1) do |(url, count), index|
        t <<  [index, url, "#{count} #{type}"]
      end
    end
    puts table
  end
end
