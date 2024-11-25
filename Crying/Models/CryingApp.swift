//
//  CryingApp.swift
//  Crying
//
//  Created by Stephanie Ananth on 11/23/24.
//

import SwiftUI
import SwiftData

@main
struct CryingApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CrySession.self,
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )

        do {
            return try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
