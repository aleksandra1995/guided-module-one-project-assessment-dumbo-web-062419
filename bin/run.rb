require_relative '../config/environment'
require 'rest-client'
require 'pry'
require 'json'
require 'tty-prompt'

class BookClub
puts "Welcome to the BookClub!"
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
||=|=|=|=|=|=|=|=|=|=|=| __..\/ |  |_|  ||#||==|  / /|
|| | | | | | | | | | | |/\ \  \\|++|=|  || ||==| / / |
||_|_|_|_|_|_|_|_|_|_|_/_/\_.___\__|_|__||_||__|/_/__|
|____________________ /\~()/()~//\ __________________|
| __   __    _  _     \_  (_ .  _/ _    ___     _____|
||~~|_|..|__| || |_ _   \ //\\ /  |=|__|~|~|___| | | |
||--|+|^^|==|1||2| | |__/\ __ /\__| |==|x|x|+|+|=|=|=|
||__|_|__|__|_||_|_| /  \ \  / /  \_|__|_|_|_|_|_|_|_|
|_________________ _/    \/\/\/    \_ _______________|
| _____   _   __  |/      \../      \|  __   __   ___|
||_____|_| |_|##|_||   |   \/ __|   ||_|==|_|++|_|-|||
||______||=|#|--| |\   \   o    /   /| |  |~|  | | |||
||______||_|_|__|_|_\   \  o   /   /_|_|__|_|__|_|_|||
|_________ __________\___\____/___/___________ ______|
|__    _  /    ________     ______           /| _ _ _|
|\ \  |=|/   //    /| //   /  /  / |        / ||%|%|%|
| \/\ |*/  .//____//.//   /__/__/ (_)      /  ||=|=|=|
|  \/\|/   /(____|/ //                    /  /||~|~|~|
|___\_/   /________//   ________         /  / ||_|_|_|
|___ /   (|________/   |\_______\       /  /| |______|
    /                  \|________)     /  / | |
"
def initialize 
    @prompt = TTY::Prompt.new
    @current_user = nil
    # @current_forum = nil
end
# prompt.select("Are you a new or returning User?", %w(new returning))

def all_user_initial_interaction
    @prompt.select("Are you a new or returning User?") do |menu|
        menu.choice "New", -> do 
            puts ('Hello! Welcome Aboard! Please choose a username') 
            new_user = gets.chomp
            new_user_to_users_table(new_user)
            new_user_first_selection 
        end
        menu.choice "Returning", -> do 
            # puts "Please enter your user name"
        returning_user = @prompt.ask("Please enter your user name") # gets.chomp
        @current_user = User.find_by(name: returning_user)
        puts "Welcome back #{returning_user}"
        returning_user_first_selection 
    end
        
    end
end

def new_user_to_users_table(new_users)
    new_users = User.create(name: new_users)
end
    

def returning_user_first_selection
   
    @prompt.select("What would you like to do?") do |menu|
        menu.choice "1- Create a new forum", -> {@prompt.ask("What's your new forum's title?")}
        menu.choice "2- Find a forum", -> {@prompt.ask("What's the forum's name?")}
        menu.choice "3- Update your forum", -> {@prompt.ask("What's the forum's name?")}
    end
end

def new_user_first_selection
    @prompt.select("What would you like to do?") do |menu|
        menu.choice "1- Create a new forum", -> do 
            puts ("What's your new forum's title?")
            new_forum = get.chomp
            new_forum_to_forums_table(new_forum)
    end
        menu.choice "2- Find a forum", -> {@prompt.ask("What's the forum's name?")}
end


end

def new_forum_to_forums_table(new_forum)
    new_forum = User.create(name: new_forum)
end


end

cli = BookClub.new
cli.all_user_initial_interaction

binding.pry


