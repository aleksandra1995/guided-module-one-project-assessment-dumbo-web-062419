%w(Aleks Olga Tony Annie Ayana Michelle Irina Ali Jahaziel Peter Rashad Bobby Larry Joe Daniel Ishmet Chris Laurell Lawson Aliciea Dennis Emmanuel Amrit).each { |name| User.create(name: name) }

["Twilight", "Little Women", "Harry Potter", "The Hobbit"].each { |title| Book.create(title: title) }


# response = RestClient.get(
#       "https://www.googleapis.com/books/v1/volumes?q=#{book_title}"
#     )
#     book_data_hash = JSON.parse(response.body)
   
#     book_titles = book_data_hash["items"].map do |books|
#         title = books["volumeInfo"]["title"]
#         Book.create(title: title)
#     end