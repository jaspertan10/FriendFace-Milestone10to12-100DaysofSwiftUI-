//
//  ContentView.swift
//  FriendFace
//
//  Created by Jasper Tan on 12/30/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        
        NavigationStack {
            List(users, id: \.id) { user in
                HStack {
                    Image(systemName: user.isActive ? "circle.fill" : "circle")
                        .foregroundStyle(user.isActive ? .green : .gray)
                    
                    NavigationLink(user.name, value: user)
                }
            }
            .navigationTitle("FriendFace")
            .navigationDestination(for: User.self, destination: { userSelection in
                UserDetails(user: userSelection)
            })
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        
        print("loadData()")
        
        //Ensure user array is empty to prevent download start every time view is shown
        guard users.isEmpty else {
            print("User array has items")
            return
        }
        
        //Create the URL we want to read
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        //Fetch the data for that URL
        do {
            print("Fetching items")
            
            //.data(from:) takes a URL and returns Data object of that URL
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //Set decoding strategy of the date to iso8601
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            //Decode the result of that data into a User struct using JSONDecoder()
            let decodedResponse = try decoder.decode([User].self, from: data)
            
            
            //users = decodedResponse
            for user in decodedResponse {
                modelContext.insert(user)
            }
            
            
        } catch {
            print("Invalid Data: \(error.localizedDescription)")
            print(String(describing: error)) // <- ✅ Use this for debugging!
        }
    }
}

#Preview {
    ContentView()
}

