//
//  Webservice.swift
//  NewsAppSwiftUI
//
//  Created by Nishanth on 24/08/24.
//

import Foundation


enum NetworkURL: String{
    case channelList = "https://newsapi.org/v2/sources?apiKey=0cf790498275413a9247f8b94b3843fd"
    case headlineNews = "https://newsapi.org/v2/top-headlines?sources=newsid&apiKey=0cf790498275413a9247f8b94b3843fd"
}


enum NetworkError: Error, LocalizedError{
    case invalidURL
    case serverNotReachable
    case decodingError
    case noDataFound
    case someErrorFound
    var localizedError: String{
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .serverNotReachable:
            return "Server is Not Reachable"
        case .decodingError:
            return "Decoding Error from Model"
        case .noDataFound:
            return "No Data Found"
        case .someErrorFound:
            return "Something happend please try again later"
        }
    }
}

enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case update = "UPDATE"
}




class ApiBuilder<T: Decodable>{
    var url: String
    var method: HttpMethod = .get
    var body: Data? = nil
    
    init(url: String){
        self.url = url
    }
}

class Webservice{
    
    static let sharedInstance = Webservice()
    
    private init(){}

    func webRequest<T>(apiRequestBuilder: ApiBuilder<T>) async throws -> T?{
        
        do{
            guard let urlstring = URL(string: apiRequestBuilder.url) else {
                throw NetworkError.invalidURL
            }
            var urlRequest = URLRequest(url: urlstring)
            urlRequest.httpMethod = apiRequestBuilder.method.rawValue
            if apiRequestBuilder.body != nil{
                urlRequest.httpBody = apiRequestBuilder.body
            }
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let status = response as? HTTPURLResponse, status.statusCode == 200 else{
                throw NetworkError.serverNotReachable
            }
            do{
                return try JSONDecoder().decode(T.self, from: data)
            }
            catch{
                throw NetworkError.decodingError
            }
            
        }
        catch{
            throw NetworkError.someErrorFound
        }
    }
    
    
}
