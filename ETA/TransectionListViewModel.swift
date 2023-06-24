//
//  TransectionListViewModel.swift
//  ETA
//
//  Created by Sonu Kumar on 21/06/23.
//

import Foundation
import Combine

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
                    dump(response)
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
}
