//
//  ContentView.swift
//  Property360
//
//  Created by Edmund Yu on 15/2/2022.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @EnvironmentObject private var model: Property360ViewModel
    @State private var schoolType: Int = 0
    @State private var amenityType: Int = 0
    
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string: model.firstImageUrl),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.size.width)
                },
                placeholder: {
                    ProgressView()
                }
            )
            
            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 5) {
                    ForEach(model.imagesUrls, id: \.self) { url in
                        AsyncImage(
                            url: URL(string: url),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 65)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                    }
                }
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("\(model.address)")
                        .font(Font.headline)
                    
                    Text ("£\(model.price)")
                    
                    Text("\(model.subType)")
                    
                    HStack(alignment: .center, spacing: 10) {
                        Text("Bedrooms \(model.bedrooms)")
                        Text("Bathrooms \(model.bathrooms)")
                    }
                    
                    Picker("Nearby Schools", selection: $schoolType, content: {
                        Text("Outstanding (\(model.nearbySchools.count))").tag(0)
                        Text("Good (\(model.goodRatingCounts))").tag(1)
                        Text("Bad (\(model.reqImprovementCounts))").tag(2)
                    }).pickerStyle(SegmentedPickerStyle())
                    
                    ForEach(model.nearbySchools, id: \.self) { ns in
                        HStack {
                            Text("\(ns.name)")
                                .font(Font.footnote)
                            
                            Spacer()
                            
                            Text("\(String(format: "%.2f", ns.distance)) miles")
                                .font(Font.footnote)
                        }.padding([.leading, .trailing], 8)
                    }
                    
                    Picker("Nearby Amenities", selection: $amenityType, content: {
                        Text("Supermarkets (\(model.nearbySupermarkets.count))").tag(0)
                        Text("Parks (\(model.nearbyParks.count))").tag(1)
                        Text("Train stations (\(model.nearbyTrainStations.count))").tag(2)
                    }).pickerStyle(SegmentedPickerStyle())
                    
                    ForEach(model.nearbySupermarkets, id: \.self) { ns in
                        HStack {
                            Text("\(ns.name)")
                                .font(Font.footnote)
                            
                            Spacer()
                            
                            Text("\(String(format: "%.2f", ns.distance*0.000621371)) miles / \(ns.duration/60) mins")
                                .font(Font.footnote)
                        }.padding([.leading, .trailing], 8)
                    }
                    
                    Text("Nearby Crimes for Last 12 months")
                        .font(Font.headline)
                    
                    ForEach(model.nearbyCrimeCounts, id: \.self) { nc in
                        HStack {
                            Text("\(nc.type)")
                                .foregroundColor(nc.colour)
                                .font(Font.footnote)
                                .fontWeight(nc.colour == .red ? .bold : .regular)
                            
                            Spacer()
                            
                            Text("\(nc.count)")
                                .foregroundColor(nc.colour)
                                .font(Font.footnote)
                                .fontWeight(nc.colour == .red ? .bold : .regular)
                            
                        }.padding([.leading, .trailing], 8)
                    }
                    
//                    Text("\(model.description)")
//                        .font(Font.subheadline)
//                        .padding(.top, 10)
                    
                }
                .padding(8)
            }
        }
        .onAppear {
            model.firstCall()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
