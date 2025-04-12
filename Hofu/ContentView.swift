//
//  ContentView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 17/11/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 1
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView().tag(1).toolbar(.hidden, for: .tabBar)
            VStack {
                Text("Search Page")
            }.padding().tag(2).toolbar(.hidden, for: .tabBar)
            VStack {
                Text("QR Scan Page")
            }.padding().tag(3).toolbar(.hidden, for: .tabBar)
            VStack {
                Text("Bookmark Page")
            }.padding().tag(4).toolbar(.hidden, for: .tabBar)
            ProfileView().tag(5).toolbar(.hidden, for: .tabBar)
        }.overlay(alignment: .bottom) {
            ContentViewTab(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthManager())
        .environmentObject(RouteManager())
}
