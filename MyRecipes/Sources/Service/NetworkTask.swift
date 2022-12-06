//
//  NetworkTask.swift
//  MyRecipes
//
//  Created by User on 05.12.2022.
//

import Foundation

let baseURL = "https://test.kode-t.ru/"

final class NetworkTask {

    static let shared = NetworkTask()

    private init() {}

    func getAllRecipes(completion: @escaping (Result<RecipeListResponse, Error>) -> Void) {
        guard let url = URL(string: baseURL + "recipes") else { return }
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

//    func getRecipe(uuid: String, completion: @escaping (Result<RecipeResponse, Error>) -> Void) {
//        guard let url = URL(string: baseURL + "recipes/" + uuid) else { return }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//            }
//            if let data = data {
//                do {
//                    let result = try JSONDecoder().decode(RecipeResponse.self, from: data)
//                    completion(.success(result))
//                } catch let error {
//                    completion(.failure(error))
//                }
//            }
//        }
//        task.resume()
//    }
}
