//
//  CustomTopAppBar.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI

struct CustomTopAppBar: ViewModifier {
    let title: String
    let leadingIcon: String?
    let navbarTitleDisplayMode: NavigationBarItem.TitleDisplayMode
    let onLeadingTap: (() -> Void)?
    let trailingIcon: String?
    let onTrailingTap: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .toolbar {
                if let leadingIcon = leadingIcon {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            onLeadingTap?()
                        }) {
                            Image(systemName: leadingIcon)
                                .foregroundColor(Color.theme.onSurfaceColor)
                        }
                    }
                }

                if let trailingIcon = trailingIcon {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            onTrailingTap?()
                        }) {
                            Image(systemName: trailingIcon)
                                .foregroundColor(Color.theme.primaryColor)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(navbarTitleDisplayMode)
    }
}



struct TopAppBar_Previews: View {
    var body: some View {
        NavigationView{
            VStack{
                Text("Test screen")
                    .customTopAppBar(
                        title: "My Screen",
                        leadingIcon: "chevron.backward",
                        navbarTitleDisplayMode: .inline,
                        onLeadingTap: {
                            print("Back tapped")
                        },
                        trailingIcon: "moon.fill",
                        onTrailingTap: {
                            print("Settings tapped")
                        }
                    )
            }
        }
    }
   
}


#Preview {
    TopAppBar_Previews()

}
