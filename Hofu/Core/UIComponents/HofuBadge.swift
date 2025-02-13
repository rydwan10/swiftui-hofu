//
//  HofuBadge.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 15/01/25.
//

import SwiftUI

enum HofuBadgeType {
    case warning
    case success
    case error
    case info
}

struct HofuBadge: View {
    let leadingIcon: Image?
    let trailingIcon: Image?
    let title: String?
    let type: HofuBadgeType

    init(type: HofuBadgeType, title: String? = nil, leadingIcon: Image? = nil, trailingIcon: Image? = nil) {
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.title = title
        self.type = type
    }

    func getBgColorByType() -> Color? {
        switch type {
        case .warning:
            .warning100
        case .success:
            .success100
        case .error:
            .error100
        case .info:
            .brand100
        }
    }

    func getColorByType() -> Color? {
        switch type {
        case .warning:
            .warning400
        case .success:
            .success400
        case .error:
            .error400
        case .info:
            .brand400
        }
    }

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            if let leadingIcon = leadingIcon {
                leadingIcon
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(getColorByType()!)
                    .frame(width: 12, height: 12)
            }
            Text(title ?? "").style(.tiny(.semiBold)).foregroundStyle(getColorByType()!)
            if let trailingIcon = trailingIcon {
                trailingIcon
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(getColorByType()!)
//                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 4)
        .background(getBgColorByType()!)
        .clipShape(RoundedRectangle(cornerRadius: 999))
    }
}

#Preview {
    VStack {
        HofuBadge(
            type: .success, title: "Badge",
            leadingIcon: Image("ic_restaurant_menu"),
            trailingIcon: Image("ic_restaurant_menu")
        )
        HofuBadge(
            type: .warning, title: "Badge",
            leadingIcon: Image("ic_restaurant_menu"),
            trailingIcon: Image("ic_restaurant_menu")
        )
        HofuBadge(
            type: .info, title: "Badge",
            leadingIcon: Image("ic_restaurant_menu"),
            trailingIcon: Image("ic_restaurant_menu")
        )
        HofuBadge(
            type: .error,
            title: "Badge",
            leadingIcon: Image("ic_restaurant_menu"),
            trailingIcon: Image("ic_restaurant_menu")
        )
    }
    
}
