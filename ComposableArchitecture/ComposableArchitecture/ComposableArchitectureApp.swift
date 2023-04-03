//
//  ComposableArchitectureApp.swift
//  ComposableArchitecture
//
//  Created by Sujin Jin on 2023/04/01.
//

import SwiftUI

@main
struct ComposableArchitectureApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(
                initialValue: AppState(),
                reducer: counterReducer)
            )
        }
    }
}
