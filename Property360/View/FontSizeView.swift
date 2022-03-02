//
//  FontSizeView.swift
//  Property360
//
//  Created by Edmund Yu on 25/2/2022.
//

import SwiftUI

struct FontSizeView: View {
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 8) {
            Text("Headline Style")
                .font(Font.headline)
            Text("Subheadline Style")
                .font(Font.subheadline)
            Text("Title Style")
                .font(Font.title)
            Text("Title2 Style")
                .font(Font.title2)
            Text("Title3 Style")
                .font(Font.title3)
            Text("LargeTitle Style")
                .font(Font.largeTitle)
            Text("Body Style")
                .font(Font.body)
            Text("Footnote Style")
                .font(Font.footnote)
            Text("Caption Style")
                .font(Font.caption)
            Text("Caption 2 Style")
                .font(Font.caption2)
        }
    }
}

struct FontSizeView_Previews: PreviewProvider {
    static var previews: some View {
        FontSizeView()
    }
}
