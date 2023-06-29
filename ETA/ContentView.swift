//
//  ContentView.swift
//  ETA
//
//  Created by Sonu Kumar on 19/06/23.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transectionListVM : TransectionListViewModel
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    let data = transectionListVM.accumulateTransections()
                    if !data.isEmpty {
                        let totalExpanse = data.last?.1 ?? 0
                        
                        CardView{
                            VStack(alignment: .leading){
                                ChartLabel(totalExpanse.formatted(.currency(code: "INR")), type: .title, format: "₹%.02f")
                                LineChart()
                            }.background(Color.systemBackground)
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 300)
                    }
                    
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
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transectionListVM : TransectionListViewModel = {
        let transectionListVM = TransectionListViewModel()
        transectionListVM.transections = transectionListPreviewdata
        return transectionListVM
    }()
    static var previews: some View {
        Group{
            ContentView()
            ContentView().preferredColorScheme(.dark)
        }
            .environmentObject(transectionListVM)
    }
}

