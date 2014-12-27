# I have a bunch of phone numbers, plz normalize them

phones = ['123 123 1234', '123-123-1234', '232  jiuji312 4123']

normalized_phones = ['123|1231234','123|1231234','232|3124123']

def normalize_numbers(phones)
  normalized_phones = []

  phones.each do |phone|
    normalized_phone = phone.gsub(/\D+/, '')
    normalized_phones << normalized_phone
  end

  normalized_phones
end

def count_nums(phone)
  counts = {}

  phones.each do |phone|
    counts[phone] = counts[phone].is_nil? ? 1 : counts[phone] + 1
  end

  counts
end

def filter_duplicates(phone)

end

def verify_ten_digits(phones)


  [good_phones, bad_phones]
end

puts normalize_numbers(phones)


post /org/1
get /org/1
get /org/
  delete /org/

  get /org/1/user/10
post /org/1/user/10
get /org/1/user/

  /org/1/user/add
/org/imgur/user/asdf
/org/imgur/user/1231/

  42.com/123123/
  42.com
