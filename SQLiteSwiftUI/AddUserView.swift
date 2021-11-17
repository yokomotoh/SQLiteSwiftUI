//
//  AddUserView.swift
//  SQLiteSwiftUI
//
//  Created by vincent schmitt on 17/11/2021.
//

import SwiftUI

struct AddUserView: View {
     
    // create variables to store user input values
    @State var username: String = ""
    @State var email: String = ""
    @State var age: String = ""
    @State var price: String = ""
    
    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    var body: some View {
         
        VStack {
            // create name field
            TextField("Enter username", text: $username)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .disableAutocorrection(true)
             
            // create email field
            TextField("Enter email", text: $email)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
             
            // create age field, number pad
            TextField("Enter age", text: $age)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
            
            // create age field, number pad
            TextField("Enter price", text: $price)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
             
            // button to add a user
            Button(action: {
                // call function to add row in sqlite database
                DB_Manager().addUser(usernameValue: self.username, emailValue: self.email, ageValue: Int64(self.age) ?? 0, priceValue: Int64(self.price) ?? 0)
                 
                // go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Add User")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
         
    }
}
