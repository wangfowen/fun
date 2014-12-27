require 'csv'
require 'date'
require 'pg'

file = 'sdata.csv'
options = {:headers => :first_row, :row_sep => :auto, :col_sep => ";"}

#activity text NOT NULL, category varchar(5), time_spent numeric, on_date timestamp NOT NULL, rating smallint, notes text

conn = PGconn.open(:dbname => "ohlife")

CSV.foreach(file, options) do |row|
  #on_date
  start_time = DateTime.parse(row[0])
  #at night, so is that day
  if (start_time.hour > 12)
    start_time = start_time.to_date
  #in morning, so is from previous day
  else
    start_time = start_time.to_date - 1
  end
  #rating
  quality = row[2].to_i
  #time_spent
  sleep_time = row[3].split(":")
  sleep_time = sleep_time[0].to_i + sleep_time[1].to_f / 60
  #notes
  notes = row[5]
  #category = sl
  #activity = sleep
  res = conn.exec_params("INSERT into data(activity, category, time_spent, on_date, rating, notes) values('sleep', 'sl', $1, $2, $3, $4)", [sleep_time, start_time, quality, notes]);
end

