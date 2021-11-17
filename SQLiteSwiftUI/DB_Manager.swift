//
//  DB_Manager.swift
//  SQLiteSwiftUI
//
//  Created by vincent schmitt on 17/11/2021.
//

import Foundation

// import library
import SQLite
 
class DB_Manager {
     
    // sqlite instance
    private var db: Connection!
     
    // table instance
    private var users: Table!
 
    // columns instances of table
    private var id: Expression<Int64>!
    private var username: Expression<String>!
    private var email: Expression<String>!
    private var age: Expression<Int64>!
    private var price: Expression<Int64>!
     
    // constructor of this class
    init () {
         
        // exception handling
        do {
             
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
 
            // creating database connection
            db = try Connection("\(path)/my_users.sqlite3")
            //db = try Connection("/Applications/MAMP/db/sqlite/test.db")
            
            // creating table object
            users = Table("users")
             
            // create instances of each column
            id = Expression<Int64>("id")
            username = Expression<String>("name")
            email = Expression<String>("email")
            age = Expression<Int64>("age")
            price = Expression<Int64>("price")
             
            // check if the user's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
 
                // if not, then create the table
                try db.run(users.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(username)
                    t.column(email, unique: true)
                    t.column(age)
                    t.column(price)
                })
                 
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
             
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
         
    }
    
    public func addUser(usernameValue: String, emailValue: String, ageValue: Int64, priceValue: Int64) {
        do {
            try db.run(users.insert(username <- usernameValue, email <- emailValue, age <- ageValue, price <- priceValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // return array of user models
    public func getUsers() -> [UserModel] {
         
        // create empty array
        var userModels: [UserModel] = []
     
        // get all users in descending order
        users = users.order(id.desc)
     
        // exception handling
        do {
     
            // loop through all users
            for user in try db.prepare(users) {
     
                // create new model in each loop iteration
                let userModel: UserModel = UserModel()
     
                // set values in model from database
                userModel.id = user[id]
                userModel.username = user[username]
                userModel.email = user[email]
                userModel.age = user[age]
                userModel.price = user[price]
     
                // append in new array
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return userModels
    }
    
    // get single user data
    public func getUser(idValue: Int64) -> UserModel {
     
        // create an empty object
        let userModel: UserModel = UserModel()
         
        // exception handling
        do {
     
            // get user using ID
            let user: AnySequence<Row> = try db.prepare(users.filter(id == idValue))
     
            // get row
            try user.forEach({ (rowValue) in
     
                // set values in model
                userModel.id = try rowValue.get(id)
                userModel.username = try rowValue.get(username)
                userModel.email = try rowValue.get(email)
                userModel.age = try rowValue.get(age)
                userModel.price = try rowValue.get(price)
            })
        } catch {
            print(error.localizedDescription)
        }
     
        // return model
        return userModel
    }
    
    // function to update user
    public func updateUser(idValue: Int64, usernameValue: String, emailValue: String, ageValue: Int64, priceValue: Int64) {
        do {
            // get user using ID
            let user: Table = users.filter(id == idValue)
             
            // run the update query
            try db.run(user.update(username <- usernameValue, email <- emailValue, age <- ageValue, price <- priceValue))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // function to delete user
    public func deleteUser(idValue: Int64) {
        do {
            // get user using ID
            let user: Table = users.filter(id == idValue)
             
            // run the delete query
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
}
