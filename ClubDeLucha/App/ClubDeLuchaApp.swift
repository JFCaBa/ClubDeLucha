//
//  ClubDeLuchaApp.swift
//  ClubDeLucha
//
//  Created by Jose on 28/10/2024.
//

import SwiftUI

@main
struct ClubDeLuchaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
