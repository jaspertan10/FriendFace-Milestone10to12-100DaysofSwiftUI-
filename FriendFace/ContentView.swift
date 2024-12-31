//
//  ContentView.swift
//  FriendFace
//
//  Created by Jasper Tan on 12/30/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [User] = []
    
    var body: some View {
        
        Text("Hello World")
        
        List(users, id: \.id) { user in
            Text(user.name)
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        
        //Create the URL we want to read
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        //Fetch the data for that URL
        do {
            //.data(from:) takes a URL and returns Data object of that URL
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //Decode the result of that data into a User struct using JSONDecoder()
            let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                users = decodedResponse
                print("X")
            
        } catch {
            print("Invalid Data: \(error.localizedDescription)")
            print(String(describing: error)) // <- ✅ Use this for debugging!
        }
    }
}

#Preview {
    ContentView()
}

