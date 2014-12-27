require 'date'
require 'pg'

FILE_NAME = "odata.txt"
DATE_REGEX = /^\s*\d{4}-\d{2}-\d{2}\s*$/
TASKS_REGEX = /\{[tT]asks\}/
EMPTY_REGEX = /^\s*$/
DATA_REGEX = /\-([\s\w,\/\.:_\<\>\*\$\!\^\%\(\\+\=)\#@\"']+)\[(\w{2}),\s*([\d\.]+)\](\s*\~\s*([\w]+[,\s\w]*))?/
CONN = PGconn.open(:dbname => "ohlife")

#activity text NOT NULL, category varchar(5), time_spent numeric, on_date timestamp NOT NULL, people text

def extract_data(line, date)
  match = DATA_REGEX.match(line)

  if match.nil?
    return false
  end

  activity = match[1].strip
  category = match[2].strip
  time_spent = match[3].to_f
  people = ""

  if !(match[4].nil?)
    people = match[5].strip
  end

  res = CONN.exec_params("INSERT into data(activity, category, time_spent, on_date, people) values($1, $2, $3, $4, $5)", [activity, category, time_spent, date, people]);

  true
end

File.open(FILE_NAME, "r") do |file|
  line = ""
  date = DateTime.now
  parse = false

  while !(line = file.gets).nil?
    if DATE_REGEX.match(line)
      date = DateTime.parse(line)
      next
    end

    if TASKS_REGEX.match(line)
      parse = true
      extract_data(line, date)
      next
    end

    if (parse && (EMPTY_REGEX.match(line) || extract_data(line, date)))
      next
    else
      parse = false
    end

  end
end

