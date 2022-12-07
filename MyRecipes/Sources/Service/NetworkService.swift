//
//  NetworkTask.swift
//  MyRecipes
//
//  Created by User on 05.12.2022.
//

import Foundation

final class NetworkService {

    static let shared = NetworkService()

    private init() {}

    func getAllRecipes(completion: @escaping (Result<RecipeListResponse, Error>) -> Void) {
        guard let url = URL(string: Constants.Strings.baseURL) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(RecipeListResponse.self, from: data)
                    completion(.success(result))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
