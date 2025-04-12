//
//  HofuLogo.swift
//  Hofu
//
//  Created by Muhammad Rydwan on 17/11/24.
//

import SwiftUI

struct HofuLogo: View {
    
    var body: some View {
        HStack (alignment: .center, spacing: 0){
            Text("Ho").font(.title).fontWeight(.bold).underline()
            Text("Fu").font(.title).fontWeight(.bold)
        }
//        .foregroundStyle(Color(hex: 0xffb7d7))
        .foregroundStyle(Color(.white))
    }
}

#Preview {
    HofuLogo()
}
