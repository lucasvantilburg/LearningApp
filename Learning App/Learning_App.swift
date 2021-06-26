//
//  Learning_AppApp.swift
//  Learning App
//
//  Created by Lucas Van Tilburg on 26/6/21.
//

import SwiftUI

@main
struct Learning_App: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
