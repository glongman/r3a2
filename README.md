    /users{.:format}
    GET     - list of users
    POST    - create a new user record
    PUT     - not valid
    DELETE  - not valid

representation - collection of user records
todo = paging

    /users/{id}{.:format}
    GET     - return a user record
    POST    - not valid
    PUT     - update a user record
    DELETE  - delete a user record

representation - user record

    /users/{id}/lock{.:format}
    GET     - return lock for identified user 
    POST    - not valid
    PUT     - lock a user
    DELETE  - unlock a user
    representation - object with url to user and lock timestamp; missing stamp means not locked.


 