//
//  Property360App.swift
//  Property360
//
//  Created by Edmund Yu on 15/2/2022.
//

import SwiftUI

@main
struct Property360App: App {
    @StateObject var model = Property360ViewModel()
    var body: some Scene {
        WindowGroup {
            PropertyView().environmentObject(model)
        }
    }
}
