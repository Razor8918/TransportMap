//
//  NetworkManager.swift
//  TransportMap
//
//  Created by Георгий Попандопуло on 24.02.2022.
//

import Foundation
import CoreLocation

final class NetworkManager {
    func fetchCurrentStations(completion: @escaping((TransportModel) -> Void)) {
        let urlString = "https://api.mosgorpass.ru/v8.2/stop"
        
        performRequest(
            urlString: urlString,
            decodeType: TransportModel.self,
            completion: completion
        )
    }
    
    func fetchStationInfo(
        id: String,
        completion: @escaping((StationInfoModel) -> Void)
    ) {
        let urlString = "https://api.mosgorpass.ru/v8.2/stop/" + id
        
        performRequest(
            urlString: urlString,
            decodeType: StationInfoModel.self,
            completion: completion
        )
    }
}

// MARK: - Private Methods

private extension NetworkManager {
    func performRequest<T: Decodable>(
        urlString: String,
        decodeType: T.Type,
        completion: @escaping((T) -> Void)
    ) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                  let formattedModel = self?.parseJSON(data: data, decodingType: decodeType.self)
            else { return }
            
            DispatchQueue.main.async {
                completion(formattedModel)
            }
        }
        
        task.resume()
    }
    
    func parseJSON<T>(
        data: Data,
        decodingType: T.Type) -> T? where T : Decodable {
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch let error {
                debugPrint(error)
                return nil
            }
        }
}

