//
//  Menu.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 17/11/24.
//

import SwiftUI

struct HomeMenu: View {
    @State private var isShowingSheet = false
    @EnvironmentObject var routeManager: RouteManager
    
    var body: some View {
        HStack {
            Spacer()
            HomeMenuItem(
                icon: "ic_building",
                label: "Hotel"
            ).onTapGesture {
                routeManager.navigate(to: .hotelList)
            }

            Spacer()
            HomeMenuItem(
                icon: "ic_shopping_bag",
                label: "Shopping"
            )
            Spacer()
            HomeMenuItem(
                icon: "ic_restaurant_menu",
                label: "Food"
            )
            Spacer()
            HomeMenuItem(
                icon: "ic_more_menu",
                label: "More"
            ).onTapGesture {
                isShowingSheet.toggle()
            }.sheet(isPresented: $isShowingSheet,
                    onDismiss: nil)
            {
                VStack {
                    Text("More menu here later")
                        .font(.title)
                        .padding(50)
                    Text("""
                        This is more menu content.
                    """)
                    .padding(50)
                    Button("Dismiss",
                           action: { isShowingSheet.toggle() })
                }.presentationDetents([.height(500), .medium, .large])
                    .presentationDragIndicator(.automatic)
            }
            Spacer()
        }
    }
}

struct HomeMenuItem: View {
    let icon: String
    let label: String

    var body: some View {
        VStack(alignment: .center) {
            Image(icon)
            Text(label)
                .font(.system(size: 12))
        }
        .frame(width: 74, height: 74)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(
            color: Color(hex: 0x101828, opacity: 0.1),
            radius: 8,
            x: 0,
            y: 4
        )
    }
}

#Preview {
    HomeMenu().environmentObject(RouteManager())
}
