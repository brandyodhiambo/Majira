//
//  LocationHeaderView.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct LocationHeaderView: View {
    let location: String

    var body: some View {
        Text(location)
            .font(.custom("Poppins-ExtraBold", size: 25))
            .padding()
            .frame(maxWidth: .infinity)
            .background(.clear)
            .cornerRadius(10)
    }
}

struct LocationHeaderViewPreviews: PreviewProvider {
    static var previews: some View {
        Group {
            LocationHeaderView(location: "Nairobi, Kenya")
                .previewDisplayName("Light Mode")
                .preferredColorScheme(.light)

            LocationHeaderView(location: "Nairobi, Kenya")
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
