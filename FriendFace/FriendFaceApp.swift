//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Jasper Tan on 12/30/24.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
