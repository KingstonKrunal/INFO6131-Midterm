//
//  DataStore.swift
//  medtermExam
//
//  Created by Abdalla Elnajjar on 2022-06-05.
//

import Foundation

class DataStore {
    
    static let shared =  DataStore()
    
    private let urlSession = URLSession.shared
    private let apikey = "apikey"// no need for apikey
    private let baseAPIURL = "https://jsonplaceholder.typicode.com"
    
    //create URL Components
    //Host must string "jsonplaceholder.typicode.com"
    //path "/posts"
    // queryItems is nill array are Query Parameters in URL ?name=Branch&products=[Journeys,Email,Universal%20Ads]
    func createURLComponents(host:String,path:String,queryItems: [URLQueryItem]?) -> URLComponents? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    
    //Get photo data function
    func getData( hostURl:String ,path: String, params: [String: String]?, completion: @escaping (Result<[Post], Error>) -> Void){
        
        //get parameters
        var queryItems = [URLQueryItem(name: "api_key", value: apikey)]
        
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        // create componentURL using host, path and queryItems
        guard let componentURL = createURLComponents(host: hostURl,path: path,queryItems: queryItems ) else {
            
            return
        }
        
        
        //validate URL if the url is not valide will terminate the app
        guard let validURL = componentURL.url else {
            print("URL creation failed...")
            
            return
        }
        
        //Create URL Request
        var request = URLRequest(url:validURL)
        
        //specify Get HTTP method
        request.httpMethod = "GET"
        
        urlSession.dataTask(with: request) { (data, response, error) in
            //test http responce is between 200..<= 299 this'..<' opratoer called range opratoer
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                return
            }
            //test data is valid
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            // decoding the data
            //this is how we do try catch block is swift to prevent app from hard crash
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(posts))
                }
            } catch let serializationError {
                print(serializationError)
                completion(.failure(serializationError))
            }
            
        }.resume()
    }
}




