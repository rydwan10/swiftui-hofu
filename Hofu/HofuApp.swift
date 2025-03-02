//
//  HofuApp.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 17/11/24.
//

import SwiftUI

@main
struct HofuApp: App {
    @StateObject private var routeManager = RouteManager()
    @StateObject private var authManager = AuthManager()

    init() {
//        let sharedRouteManager = RouteManager()
//        _routeManager = StateObject(wrappedValue: sharedRouteManager)
//        _authManager = StateObject(wrappedValue: AuthManager(routeManager: sharedRouteManager))
    }

    var body: some Scene {
        WindowGroup {
//            let routeManager = RouteManager()
//            let authManager = AuthManager()
//            ContentView(routeManager: routeManager, authManager: authManager)

            NavigationStack(path: $routeManager.path) {
                RootView()
                    .navigationDestination(for: AppRoute.self) { route in
                        switch route {
                            case .detail(let id):
                                Text("Detail Screen")
                            case .profile(let username):
                                Text("Profile Screen")
                            case .settings:
                                Text("Settings Screen")
                            case .hotelList:
                                HotelListView()
                                    .navigationBarTitleDisplayMode(.inline) // Menentukan tampilan title secara inline
                                    .toolbar {
                                        ToolbarItem(placement: .principal) {
                                            Text("Hotel")
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                        }
                                    }
                            case .hotelDetail(let id, let name):
                                HotelDetailView(
                                    id: id, name: name
                                ).navigationBarTitleDisplayMode(.inline) // Menentukan tampilan title secara inline
                                    .toolbar {
                                        ToolbarItem(placement: .principal) {
                                            Text(name)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                        }
                                    }
                            case .login:
                                LoginView()
                            case .register:
                                RegisterView()
                            case .home:
                                ContentView()
                        }
                    }

            }.environmentObject(authManager).environmentObject(routeManager)

//
//                .environmentObject(authManager)
        }
    }
}
