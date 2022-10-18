//
//  Badge.swift
//  ProductList
//
//  Created by Phil Martin on 17/10/2022.
//

import SwiftUI

struct Badge: View {
    let count: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            Text(String(count))
                .foregroundColor(.white)
                .font(.system(size: 14))
                .padding(4)
                .background(Color.red)
                .clipShape(Circle())
                // custom positioning in the top-right corner
                .alignmentGuide(.top) { $0[.bottom] }
                .alignmentGuide(.trailing) { $0[.trailing] - $0.width * 0.25 }
        }
        .padding(.trailing, 5)
        .padding(.top, 5)
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge(count: 5)
    }
}
