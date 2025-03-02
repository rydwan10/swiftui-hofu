//
//  HomeView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 17/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HomeHero()
                Spacer().frame(height: 24)
                HomeMenu()
                Spacer()
                HomeCard()
                Spacer()
                HomeCard()
                Spacer()
                HomeCard()
                Spacer().frame(height: 80)
            }.background(Color(.gray25))
        }.edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    HomeView().environmentObject(RouteManager())
}
