//
//  ETAApp.swift
//  ETA
//
//  Created by Sonu Kumar on 19/06/23.
//

import SwiftUI

@main
struct ETAApp: App {
    
    @StateObject var transectionListVM = TransectionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(transectionListVM)
        }
    }
}
