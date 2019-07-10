%w(Aleks Olga Tony Annie Ayana Michelle Irina Ali Jahaziel Peter Rashad Bobby Larry Joe Daniel Ishmet Chris Laurell Lawson Aliciea Dennis Emmanuel Amrit).each { |name| User.create(name: name) }

["Twilight", "Little Women", "Harry Potter", "The Hobbit"].each { |title| Book.create(title: title) }


