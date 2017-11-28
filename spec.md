# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database -ActiveRecord stores our data in the database for future use.
- [x] Include more than one model class (list of model class names e.g. User, Post, Category) -We have a model for Users, Consoles and Games.
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts) -Users can have many consoles and consoles can have many games.
- [x] Include user accounts -Stores users in ActiveRecord database.
- [x] Ensure that users can't modify content created by other users -App will not let you see other user's user page or their consoles or games.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying -Users can CRUD both consoles and games
- [x] Include user input validations -Validations used to verify users, consoles, and games
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new) -Flash messages used at places errors occur
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code -done!

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
