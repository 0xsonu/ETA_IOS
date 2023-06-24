//
//  RecentTransectionList.swift
//  ETA
//
//  Created by Sonu Kumar on 21/06/23.
//

import SwiftUI

struct RecentTransectionList: View {
    @EnvironmentObject var transectionListVM : TransectionListViewModel
    var body: some View {
        VStack{
            HStack{
                Text("Recent Transections")
                    .bold()
                
                Spacer()
                
                NavigationLink{
                    TransectionList()
                } label: {
                    HStack(spacing: 4){
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.text)
                }
            }
            .padding(.top)
            
            // Recent Transection List
            ForEach(Array(transectionListVM.transections.prefix(5).enumerated()), id: \.element) { index, transection in
                TransectionRow(transection: transection)
                Divider()
                    .opacity(index == 4 ? 0: 1 )
                
            }
            
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
    
}

struct RecentTransectionList_Previews: PreviewProvider {
    static let transectionListVM : TransectionListViewModel = {
        let transectionListVM = TransectionListViewModel()
        transectionListVM.transections = transectionListPreviewdata
        return transectionListVM
    }()
    static var previews: some View {
        RecentTransectionList()
            .environmentObject(transectionListVM)
    }
}
