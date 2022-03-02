//
//  SearchView.swift
//  Property360
//
//  Created by Edmund Yu on 21/2/2022.
//

import SwiftUI

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber || $0 == "."}
            
            if value != filtered {
                value = filtered
            }
        }
    }
}

struct PTextField: View {
    var label: String
    var placeHolderLabel: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text("\(label)")
                .font(Font.headline)
            
            TextField("\(placeHolderLabel)", text: $value)
                .foregroundColor(.gray)
                .font(Font.body.bold())
                .padding([.top, .bottom], 14)
                .padding(.horizontal, 20)
                .background(Color(.systemGray6))
                .cornerRadius(5)
        }
    }
}

struct PNumberField: View {
    var label: String
    var placeHolderLabel: String
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text("\(label)")
                .font(Font.headline)
            
            TextField("\(placeHolderLabel)", text: $value)
                .keyboardType(.decimalPad)
                .foregroundColor(.gray)
                .font(Font.body.bold())
                .padding([.top, .bottom], 14)
                .padding(.horizontal, 20)
                .background(Color(.systemGray6))
                .cornerRadius(5)
        }
    }
}

struct SearchView: View {
    @EnvironmentObject private var model: ApplicationViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: HorizontalAlignment.leading, spacing: 8) {
                PTextField(label: "Location", placeHolderLabel: "Cities of UK (e.g. London)", value: $model.searchViewModel.location)
                    .padding(.bottom)
                
                PNumberField(label: "Proximity in miles", placeHolderLabel: "0.25 miles", value: $model.searchViewModel.radius.value)
                    .padding(.bottom)
                
                Text("Price")
                    .font(Font.headline)
                
                HStack {
                    TextField("min (£)", text: $model.searchViewModel.minPrice.value)
                        .keyboardType(.decimalPad)
                        .foregroundColor(.gray)
                        .font(Font.body.bold())
                        .padding([.top, .bottom], 14)
                        .padding(.horizontal, 20)
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                    
                    TextField("max (£)", text: $model.searchViewModel.maxPrice.value)
                        .keyboardType(.decimalPad)
                        .foregroundColor(.gray)
                        .font(Font.body.bold())
                        .padding([.top, .bottom], 14)
                        .padding(.horizontal, 20)
                        .background(Color(.systemGray6))
                        .cornerRadius(5)
                }
                
                Spacer()
                
                Button(action: {
                    model.searchProperties()
                }, label: {
                    HStack(spacing: 6) {
                        if model.fetchingProperty {
                            ProgressView()
                        }
                        
                        Text("Search 360")
                            .bold()
                    }
                    .frame(maxWidth: UIScreen.main.bounds.size.width)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)

                }).disabled(model.fetchingProperty)
                
                NavigationLink(destination: PropertyListingView(), isActive: $model.showPropertyListing) { EmptyView() }
            }
            .navigationTitle("Search Property")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
