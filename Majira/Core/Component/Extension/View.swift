//
//  View.swift
//  Majira
//
//  Created by Brandy Odhiambo on 07/07/2025.
//

import SwiftUI


extension View {
    func customTopAppBar(
        title: String,
        leadingIcon: String? = nil,
        navbarTitleDisplayMode: NavigationBarItem.TitleDisplayMode = .inline,
        onLeadingTap: (() -> Void)? = nil,
        trailingIcon: String? = nil,
        onTrailingTap: (() -> Void)? = nil
    ) -> some View {
        self.modifier(CustomTopAppBar(
            title: title,
            leadingIcon: leadingIcon,
            navbarTitleDisplayMode: navbarTitleDisplayMode,
            onLeadingTap: onLeadingTap,
            trailingIcon: trailingIcon,
            onTrailingTap: onTrailingTap
        ))
    }
}
