//
//  SearchView.swift
//  Property360
//
//  Created by Edmund Yu on 21/2/2022.
//

import SwiftUI

struct SearchView: View {
    @State var location: String = ""
    var body: some View {
        VStack {
            Spacer()
            
            TextField(text: $location, label: {
                Text("Property Location1")
            }).padding()
            
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
