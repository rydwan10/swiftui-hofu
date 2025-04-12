//
//  RoomShopSearchBarView.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 06/03/25.
//

import SwiftUI

struct RoomShopSearchBarView: View {
    @Binding var searchQuery: String
    @Binding var isSheetPresented: Bool
    @Binding var isListView: Bool

    var body: some View {
        HStack {
            HofuTextField(
                placeholder: "Search items...",
                text: $searchQuery,
                leadingIcon: Image("ic_search_outline"),
                onLeadingIconTap: { print("Search tapped") },
                onTrailingIconTap: { print("Trailing tapped") },
                onChange: { text in
                    print("Search query: \(text)")
                }
            )

            Spacer()

            HStack {
                HofuCircleButton(icon: { Image("ic_filter_outline") })
                    .sheet(isPresented: $isSheetPresented) {
                        Text("filter here later")
                            .presentationDetents([.fraction(0.40)])
                            .presentationDragIndicator(.visible)
                    }
                HofuCircleButton(icon: { Image(isListView ? "ic_grid_outline" : "ic_list_outline") })
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isListView.toggle()
                        }
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var isListView: Bool = false
    RoomShopSearchBarView(
        searchQuery: .constant(""),
        isSheetPresented: .constant(false),
        isListView: $isListView
    )
}
