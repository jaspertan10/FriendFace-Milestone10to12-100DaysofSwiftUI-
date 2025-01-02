//
//  UserDetails.swift
//  FriendFace
//
//  Created by Jasper Tan on 1/1/25.
//

import SwiftUI

struct UserDetails: View {
    
    @State var user: User
    
    var body: some View {
        List {
            
            Section("Profile Details") {
                HStack {
                    Text("Age")
                    Spacer()
                    Text("\(user.age)")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("Company")
                    Spacer()
                    Text(user.company)
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("Registered Date")
                    Spacer()
                    Text(user.registered.formatted(date: .long, time: .omitted))
                        .foregroundStyle(.secondary)
                }
            }
            
            Section("Contact Info") {
                HStack {
                    Text("Email")
                    Spacer()
                    Text(user.email)
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("Address")
                    Spacer()
                    Text(user.address)
                        .foregroundStyle(.secondary)
                }
            }
            
            Section("Biographical Information") {
                VStack(alignment: .leading) {
                    Text("About")
                    Text(user.about)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
                
                VStack {
                    Text("Tags")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(user.tags, id: \.self) { tag in
                                Text(tag)
                                Text(" | ")
                            }
                            .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            
            Section("Social Circle") {
                VStack(alignment: .leading) {
                    Text("Friends")
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(user.friends, id: \.id) { friend in
                                Text(friend.name)
                                Text(" | ")
                            }
                            .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            
        
            Section("System Information") {
                HStack {
                    Text("User ID")
                    Spacer()
                    Text(user.id)
                        .foregroundStyle(.secondary)
                }
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text(user.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Image(systemName: user.isActive ? "circle.fill" : "circle")
                        .foregroundStyle(user.isActive ? .green : .secondary)
                }
            }
        }
    }
}

#Preview {

    let tempUser = User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", registered: DateFormatter().date(from: "2015-11-10T01:47:18-00:00") ?? .now, tags: [
        "cillum",
        "consequat",
        "deserunt",
        "nostrud",
        "eiusmod",
        "minim",
        "tempor"
    ], friends: [Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel")])

    UserDetails(user: tempUser)
}
