User Lists
==========
    /users{.:format}
    GET     - list of users
    POST    - create a new user record
    PUT     - not valid
    DELETE  - not valid

representation - collection of user records
todo = paging

User Records
============
    /users/{id}{.:format}
    GET     - return a user record
    POST    - not valid
    PUT     - update a user record
    DELETE  - delete a user record

representation - user record

User Locks
==========

    /users/{id}/lock{.:format}
    GET     - return lock for identified user 
    POST    - not valid
    PUT     - lock a user
    DELETE  - unlock a user

representation - object with url to user and lock timestamp; missing stamp means not locked.
    
User Player Lists
=================
    /users/{id}/players
    GET     - list of players for user
    POST    - create a new player for user
    PUT     - not valid
    DELETE  - not valid
    
Player Lists
============
    /players/{id}{.format}
    GET     - list of players
    POST    - create a new player record
    PUT     - not valid
    DELETE  - not valid
    
representation - collection of player records

Player Locks
============

    /players/{id}/lock{.:format}
    GET     - return lock for identified user 
    POST    - not valid
    PUT     - lock a player
    DELETE  - unlock a player

representation - object with url to user and lock timestamp; missing stamp means not locked.

Player Scores
=============
    
    /players/{id}/scores{.format}
    GET     - list of scores for player
    POST    - create a new score record
    PUT     - not valid
    DELETE  - not valid
    
representation - collection of score records
todo - paging - filtering
    
    /users/{id}/scores/{id}{.format}
    GET     - return a users' score record
    POST    - not valid
    PUT     - update a users' score record
    DELETE  - delete a score record
    
representation - score record

Score Sheets
============ 

    /scoresheets
    GET     - scoresheets for all users
    POST    - not valid
    PUT     - not valid
    DELETE  - not valid
    
representation - list of links to user score sheets
todo - paging - filtering
question - include some user info in the representation in addition to the links?
 
User Score Sheets
=================

  /users{id}/scoresheet{.format}
  /users{id}/scoresheets(.format}

