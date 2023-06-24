//
//  ContentView.swift
//  ETA
//
//  Created by Sonu Kumar on 19/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    RecentTransectionList()
                }
                .padding()
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transectionListVM : TransectionListViewModel = {
        let transectionListVM = TransectionListViewModel()
        transectionListVM.transections = transectionListPreviewdata
        return transectionListVM
    }()
    static var previews: some View {
        ContentView()
            .environmentObject(transectionListVM)
    }
}


//  45:47
