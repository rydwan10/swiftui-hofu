//
//  RootView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 09/02/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var routeManager: RouteManager
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        VStack {
            if !authManager.isAuthenticated {
                LoginView()
            } else {
                ContentView()
            }
        }
    }
}
