//
//  PropertyListingView.swift
//  Property360
//
//  Created by Edmund Yu on 25/2/2022.
//

import SwiftUI

struct PropertyListingRowView: View {
    var property: Property
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.trailing) {
            HStack(alignment: VerticalAlignment.top) {
                AsyncImage(
                    url: URL(string: property.images.count > 0 ? property.images[0].sourceUrl: ""),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 80)
                            .cornerRadius(3)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                
                VStack(alignment: HorizontalAlignment.leading, spacing: 5) {
                    Text("\(property.address!)")
                        .font(Font.caption)
                        .bold()
                    Text("£\(Int(property.price))")
                        .font(Font.caption)
                    
                    HStack {
                        Text("\(Image(systemName: "bed.double.fill")) \(property.bedrooms)")
                            .font(Font.caption)
                        
                        Text("\(Image(systemName: "hands.sparkles")) \(property.bathrooms ?? 0)")
                            .font(Font.caption)
                    }
                }
                
                Spacer()
            }
            .padding(8)
        }
        .background(Color(.systemGray6))
        .cornerRadius(5)
    }
}

struct PropertyListingView: View {
    @EnvironmentObject private var model: ApplicationViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(model.propertyListingViewModel.properties, id: \.self) { property in
                    NavigationLink(destination: PropertyView(propertyViewModel: model.populateProperty(property: property)), label: {
                        PropertyListingRowView(property: property)
                    }).buttonStyle(PlainButtonStyle())
                }

            }.padding([.leading, .trailing], 8)
        }.navigationTitle("\(model.propertyListingViewModel.properties.count) Properties Found")

    }
}

struct PropertyListingView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyListingView()
    }
}
