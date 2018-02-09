# Code/Split
A collaborative website for sharing code and instructing others in real time using WebSockets.

## Requirements
    Rails 5.1.4
    Redis
    Postgresql
    Yarn
    Node.js

## Deployment
    Add required node module codemirror:
    ```
    yarn add codemirror
    ```
    Set up Database
    ```
    rake db:create
    ```
    ```
    rake db:migrate
    ```
    Precompile assets:
    ```
    rake assets:precompile  
    ```
