require_relative '../config/environment'
require 'rest-client'
require 'pry'
require 'json'
require 'tty-prompt'
require 'colorize'
ActiveRecord::Base.logger = nil

class BookClub
puts "Welcome to the BookClub!".colorize(:red)
        puts "
         ____________________________________________________
        |____________________________________________________|
        | __     __   ____   ___ ||  ____    ____     _  __  |
        ||  |__ |--|_| || |_|   |||_|**|*|__|+|+||___| ||  | |
        ||==|^^||--| |=||=| |=*=||| |~~|~|  |=|=|| | |~||==| |
        ||  |##||  | | || | |JRO|||-|  | |==|+|+||-|-|~||__| |
        ||__|__||__|_|_||_|_|___|||_|__|_|__|_|_||_|_|_||__|_|
        ||_______________________||__________________________|
        | _____________________  ||      __   __  _  __    _ |
        ||=|=|=|=|=|=|=|=|=|=|=| __..\\/ |  |_|  ||#||==|  / /|
        || | | | | | | | | | | |/\\ \\  \\\\|++|=|  || ||==| / / |
        ||_|_|_|_|_|_|_|_|_|_|_/_/\\_.___\\__|_|__||_||__|/_/__|
        |____________________ /\\~()/()~//\\ __________________|
        | __   __    _  _     \\_  (_ .  _/ _    ___    _____ |
        ||~~|_|..|__| || |_ _   \\ //\\\\ /  |=|__|~|~|___| | | |
        ||--|+|^^|==|1||2| | |__/\\ __ /\\__| |==|x|x|+|+|=|=|=|
        ||__|_|__|__|_||_|_| /  \\ \\  / /  \\_|__|_|_|_|_|_|_|_|
        |_________________ _/    \\/\\/\\/    \\_ _______________|
        | _____   _   __  |/      \\../      \\|  __   __   ___|
        ||_____|_| |_|##|_||   |   \\/ __|   ||_|==|_|++|_|-|||
        ||______||=|#|--| |\\   \\   o    /   /| |  |~|  | | |||
        ||______||_|_|__|_|_\\   \\  o   /   /_|_|__|_|__|_|_|||
        |_________ __________\\___\\____/___/___________ ______|
        |__    _  /    ________     ______           /| _ _ _|
        |\\ \\  |=|/   //    /| //   /  /  / |        / ||%|%|%|
        | \\/\\ |*/  .//____//.//   /__/__/ (_)      /  ||=|=|=|
        |  \\/\\|/   /(____|/ //                    /  /||~|~|~|
        |___\\_/   /________//   ________         /  / ||_|_|_|
        |___ /   (|________/   |\\_______\\       /  /| |______|
            /                  \\|________)     /  / | |
        ".colorize(:blue)
def initialize 
    @prompt = TTY::Prompt.new
    @current_user = nil 
end

def all_user_initial_interaction
    @prompt.select("Are you a new or returning User?") do |menu|
        menu.choice "New", -> do 
            puts ('Hello! Welcome Aboard! Please choose a Username:')
            new_user = gets.chomp
            new_user_to_users_table(new_user)
            new_user_first_selection 
        end
        menu.choice "Returning", -> do 
            returning_user_now = @prompt.ask("Please enter your Username:") 
            if @current_user = User.find_by(name: returning_user_now)
                puts "Welcome back #{@current_user.name}!".colorize(:red)
                returning_user_first_selection  
                
            else
                @current_user == nil
                puts "Looks like you are not a User yet. Please enter a Username.".colorize(:red)
                new_user = gets.chomp
            new_user_to_users_table(new_user)
            new_user_first_selection
            
            end
        end       
    end
end

def new_user_to_users_table(new_users)
    @current_user = User.create(name: new_users)
end
    
def returning_user_first_selection
    @prompt.select("What would you like to do?") do |menu|
        menu.choice "1- Create a new forum.", -> do 
            user_response = @prompt.ask("What book would you like to discuss?")
            grab_book_from_api(user_response)
        end
        menu.choice "2- Find a forum.", -> do 
            forum_selection
        end
        menu.choice "3- Update your forum.", -> do 
            if @current_user.forums == []
            puts "You don't have any forums to update.".colorize(:red)
            forum_selection

            else
            all_my_forums
            end
        end
        menu.choice "4- Exit Program", -> {exit_program_method}
    end
end

def new_user_first_selection
    @prompt.select("What would you like to do?") do |menu|
        menu.choice "1- Create a new forum.", -> do 
            user_response = @prompt.ask("What book would you like to discuss?")

            grab_book_from_api(user_response)
            # # returning_user_first_selection   
            # @prompt.select("What would you like to do?") do |menu|
            #     menu.choice "1- Create a new forum.", -> do 
            #         user_response = @prompt.ask("What book would you like to discuss?")
            #         grab_book_from_api(user_response)
            #     end
            #     menu.choice "2- Find a forum.", -> do 
            #         forum_selection
            #     end
            #     menu.choice "3- Update your forum.", -> do 
            #         if @current_user.forums == []
            #         puts "You don't have any forums to update.".colorize(:red)
            #         forum_selection
            #         #could this be the problem?
        
            #         else
            #         all_my_forums
            #         end
            #     end
            #     menu.choice "4- Exit Program", -> {exit_program_method}
            # end        
    end
        menu.choice "2- Find a forum.", -> do 
            forum_selection
        end
        menu.choice "3- Exit Program", -> {exit_program_method}
    end
end

def exit_program_method
    @prompt.select("Would you like to end this session?") do |menu|
        menu.choice ("Yes"), -> {puts "Goodbye! Thank you for participating in our BookClub!".colorize(:red)}
        menu.choice ("No"), -> {returning_user_first_selection}
    end
end

def new_forum_to_forums_table(new_forum,new_content,new_book)
    @current_user.forums << Forum.create(forum_title: new_forum, content: new_content, book_id: new_book.id)    
end

def forum_selection
   choices = Forum.all.map {|forum| forum.forum_title}
   chosen_forum =  @prompt.select("Which forum would you like to choose?", choices) 
   puts Forum.find_by(forum_title: chosen_forum).content
   id_of_chosen_forum = Forum.find_by(forum_title: chosen_forum).id

    variable = Forum.find_by(id: id_of_chosen_forum)
    puts variable.comments.map {|cont| cont.contributions}
       
   @prompt.select("Would you like to add a comment?") do |menu|
    menu.choice "Yes", -> do
        user_comment = @current_user.name + " -> " + gets.chomp
        new_comment = Comment.create(forum_id: id_of_chosen_forum , contributions: user_comment, user_id: @current_user.id)
        puts "Your comment has been posted.".colorize(:red)
        exit_program_method
              
      end
      
    menu.choice "No", -> {returning_user_first_selection}
   end 
   
end

def all_my_forums
    
     choices = @current_user.forums.map {|forum| forum.forum_title}
    
     selected_forum = @prompt.select("Here is a list of all of your forums:", choices)
     
     selected_forum_id = Forum.find_by(forum_title: selected_forum).id
    
    @prompt.select ("What would you like to do?") do |menu|
        menu.choice "1 -Add comment", -> do 
            user_comment = @current_user.name + " -> " + gets.chomp
            new_comment = Comment.create(forum_id: selected_forum_id , contributions: user_comment)    
            puts "Your comment has been posted.".colorize(:red)
        exit_program_method
        end

        menu.choice "2 -Remove comment", -> do

            variable = Forum.find_by(id: selected_forum_id)
            
                comments_belonging_to_user = variable.comments.map {|cont| cont.contributions}
             if  
                comments_belonging_to_user == []
                puts "You do not have any comments to delete.".colorize(:red)
                    exit_program_method
                
            else
                
                choices = comments_belonging_to_user
            
                selected_comment_for_user = @prompt.select("Choose a comment to be deleted", choices)
                to_be_deleted = Comment.find_by(contributions: selected_comment_for_user)
                
                to_be_deleted.destroy
                exit_program_method
                end
        end

        menu.choice "3 -Delete forum", -> {to_destroy = Forum.find_by(forum_title: selected_forum)
        to_destroy.destroy # deletes forum in DB
        @current_user.forums.destroy(to_destroy)# delete forum from instance variable
            puts "Your forum has been deleted.".colorize(:red)
        returning_user_first_selection
        }
    end
end



def grab_book_from_api(book_title)
    response = RestClient.get(
      "https://www.googleapis.com/books/v1/volumes?q=#{book_title}"
    )
    book_data_hash = JSON.parse(response.body)
    
    book_titles = book_data_hash["items"].map do |books|
        books["volumeInfo"]["title"]
    end
    book_api_id = book_data_hash["items"].map do |books|
        books["id"]
        
    end
    
    choices = book_titles

    selected = @prompt.select("Choose a book title", choices) 
    
    created_book = Book.create(title: selected)

     new_forum = "#{created_book.title}" + " - " + @prompt.ask("What is your forum title?")

            content_array = []
            
            content_array << new_content = @prompt.ask("Kickoff discussion by adding some content!")
            
            new_forum_to_forums_table(new_forum, new_content, created_book)
            exit_program_method
    end
end


cli = BookClub.new
cli.all_user_initial_interaction
