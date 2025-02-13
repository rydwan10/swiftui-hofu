//
//  MainTabView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 08/12/24.
//

import SwiftUI

enum TabBarItem: Int, CaseIterable {
    case home = 1
    case search
    case scan
    case bookmark
    case profile

    var image: String {
        switch self {
        case .home: return "ic_home_outline"
        case .search: return "ic_search_outline"
        case .scan: return "ic_barcode_outline"
        case .bookmark: return "ic_bookmark_outline"
        case .profile: return "ic_user_outline"
        }
    }

    var title: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        case .scan: return "Scan"
        case .bookmark: return "Bookmark"
        case .profile: return "Profile"
        }
    }

    var isScanTab: Bool {
        return self == .scan
    }
}

struct ContentViewTab: View {
    @Binding var selectedTab: Int
    @State private var isScanSheetPresented = false

    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 80)
                .foregroundColor(Color(.white))
                .shadow(radius: 1)

            HStack(spacing: 24) {
                tabBarButton(for: .home)
                tabBarButton(for: .search)
                tabBarButton(for: .scan)
                tabBarButton(for: .bookmark)
                tabBarButton(for: .profile)
            }
            .frame(height: 80)
        }
        .padding(.horizontal, 8)
        .sheet(isPresented: $isScanSheetPresented) {
            ScanView() // Replace with your actual scan view
        }
    }

    @ViewBuilder
    func tabBarButton(for item: TabBarItem) -> some View {
        Button {
            if item.isScanTab {
                isScanSheetPresented = true
            } else {
                selectedTab = item.rawValue
            }
        } label: {
            VStack(spacing: .zero) {
                Spacer()
                Image("\(item.image)")
                    .renderingMode(.template)
                    .foregroundStyle(selectedTab == item.rawValue ? .brand600 : item.isScanTab ? .white : .black)
                    .padding(item.isScanTab ? 12 : 8)
                    .background(item.isScanTab ? Circle().foregroundColor(.brand600) : Circle().foregroundColor(.clear))

                if !item.isScanTab {
                    Spacer().frame(height: 2)
                    Text("\(item.title)")
                        .font(.caption)
                        .foregroundColor(selectedTab == item.rawValue ? .brand600 : .black)
                } else {
                    Spacer().frame(height: 12)
                }
                Spacer()
            }
        }
    }
}

// Placeholder ScanView - replace with your actual implementation
struct ScanView: View {
    var body: some View {
        Text("Scan view here")
            .presentationDetents([.fraction(0.75)])
            .presentationDragIndicator(.visible)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewTab(selectedTab: .constant(1))
            .previewLayout(.sizeThatFits)
    }
}
