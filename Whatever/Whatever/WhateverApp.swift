//
//  WhateverApp.swift
//  Whatever
//
//  Created by sei on 2023/06/10.
//

import SwiftUI

@main
struct WhateverApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }   
        }
    }
}
