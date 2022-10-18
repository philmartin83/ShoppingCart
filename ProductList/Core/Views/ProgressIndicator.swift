//
//  ProgressIndicator.swift
//  ProductList
//
//  Created by Phil Martin on 18/10/2022.
//

import SwiftUI

struct ProgressIndicator: View {
    var body: some View {
        ProgressView()
            .tint(.orange)
            .scaleEffect(2)
            .frame(maxWidth: .infinity)
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
