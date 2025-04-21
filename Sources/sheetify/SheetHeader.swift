//
//  SheetHeader.swift
//  Sheetify
//
//  Created by Iñaki Sigüenza on 20/04/25.
//

import SwiftUI

/// Header view with title and close button
fileprivate struct SheetHeader: View {
    /// Sheet title text
    let title: String
    /// Close action
    let onClose: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            Button(action: onClose) {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}
