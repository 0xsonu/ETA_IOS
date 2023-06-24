//
//  TransectionList.swift
//  ETA
//
//  Created by Sonu Kumar on 24/06/23.
//

import SwiftUI

struct TransectionList: View {
    @EnvironmentObject var transectionListVM : TransectionListViewModel
    var body: some View {
        VStack{
            List {
                ForEach(Array(transectionListVM.groupTransectionByMonth()), id: \.key) { month, transections in
                    Section {
                        ForEach(transections) { transection in
                            TransectionRow(transection: transection)
                        }
                    } header: {
                        Text(month)
                    }

                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("All Transections")
        .navigationBarTitleDisplayMode(.automatic)
    }
}

struct TransectionList_Previews: PreviewProvider {
    static let transectionListVM : TransectionListViewModel = {
        let transectionListVM = TransectionListViewModel()
        transectionListVM.transections = transectionListPreviewdata
        return transectionListVM
    }()
    static var previews: some View {
        NavigationView {
            TransectionList()
                .environmentObject(transectionListVM)
        }
    }
}
