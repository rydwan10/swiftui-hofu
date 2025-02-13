//
//  HotelDetail.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 13/02/25.
//

import SwiftUI

struct HotelDetailView: View {
    let id: Int
    let name: String
    
    var body: some View {
        Text("Hotel \(name) with id \(id) Detail")
    }
}

#Preview {
    HotelDetailView(id: 1, name: "Grand Hyatt")
}
