//
//  TransectionListViewModel.swift
//  ETA
//
//  Created by Sonu Kumar on 21/06/23.
//

import Foundation
import Combine
import Collections

typealias TransectionGroup = OrderedDictionary< String , [Transection]>
typealias TransectionPrefixSum = [(String, Double)]

final class TransectionListViewModel : ObservableObject {
    @Published var transections : [Transection] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransections()
    }
    
    // Network call
    func getTransections() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL to fetch transections...")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{(data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                    
                }
                return data
            }.decode(type: [Transection].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink{completion in
                switch completion{
                case .failure(let error):
                    print("Error Fetching Data : ", error)
                case .finished :
                    print("Finished Fetching Data ")
//                    return
                }
            } receiveValue: { [weak self]result in
                self?.transections = result
            }.store(in: &cancellables)
        
    }
    
    func groupTransectionByMonth() -> TransectionGroup {
        guard !transections.isEmpty else { return [:]}
        
        let groupTransection = TransectionGroup(grouping: transections, by: {$0.month})
        return groupTransection
    }
    
    func accumulateTransections() -> TransectionPrefixSum {
        print("Accumulaate Transections")
        guard !transections.isEmpty else { return [] }
        
        let today = "02/17/2022".description.dateParsed() //Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("Date Interval : ", dateInterval)
        
        var sum : Double = .zero
        var cumulativeSum = TransectionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24){
            let dailyExpanse = transections.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpanse.reduce(0) { $0 - $1.signedAmount }
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "Daily Total", dailyTotal, "Sum", sum)
        }
        return cumulativeSum
    }
}
