//
//  EditUserView.swift
//  SQLiteSwiftUI
//
//  Created by vincent schmitt on 17/11/2021.
//

import SwiftUI
 
struct EditUserView: View {
     
    // id receiving of user from previous view
    @Binding var id: Int64
     
    // variables to store value from input fields
    @State var username: String = ""
    @State var email: String = ""
    @State var age: String = ""
    @State var price: String = ""
     
    // to go back to previous view
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
            
            // create price field, number pad
                TextField("Enter price", text: $price)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
             
            // button to update user
            Button(action: {
                // call function to update row in sqlite database
                DB_Manager().updateUser(idValue: self.id, usernameValue: self.username, emailValue: self.email, ageValue: Int64(self.age) ?? 0, priceValue: Int64(self.price) ?? 0)
 
                // go back to home page
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Edit User")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
 
        // populate user's data in fields when view loaded
        .onAppear(perform: {
             
            // get data from database
            let userModel: UserModel = DB_Manager().getUser(idValue: self.id)
             
            // populate in text fields
            self.username = userModel.username
            self.email = userModel.email
            self.age = String(userModel.age)
            self.price = String(userModel.price)
        })
    }
}
 
struct EditUserView_Previews: PreviewProvider {
     
    // when using @Binding, do this in preview provider
    @State static var id: Int64 = 0
     
    static var previews: some View {
        EditUserView(id: $id)
    }
}
