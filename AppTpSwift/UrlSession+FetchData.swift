//
//  UrlSession+FetchData.swift
//  AppTpSwift
//
//  Created by Enzo Neault on 04/04/2023.
//

import Foundation

extension URLSession {
    func fetchData<T: Decodable>(at url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        self.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return;
            }
            
            if let data = data {
                do {
                    let toDos = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(toDos))
                } catch let decoderError {
                    completion(.failure(decoderError))
                }
            }
        }.resume()
    }
}
