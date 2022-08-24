//
//  NetworkManager.swift
//  RestCountriesList
//
//  Created by juris.katkovskis on 23/08/2022.
//

import Foundation

class NetworkManager{
    
    static func fetchData(completion: @escaping ([Country]) -> () ){
          guard let url = URL(string: "https://restcountries.com/v3.1/all") else {return}
          
          var request = URLRequest(url: url)
          request.httpMethod = "GET"
          
          let config = URLSessionConfiguration.default
          config.waitsForConnectivity = true
          
          URLSession(configuration: config).dataTask(with: request) { (data, responce, error) in
              guard error == nil else {
                  print(error!)
                  return
              }
              
              guard let data = data else {
                  fatalError()
                  return
              }
              
              do{
                  let jsonData = try JSONDecoder().decode([Country].self, from: data)
                  completion(jsonData)
              }catch{
                  print("err:::", error)
              }

              
              
          }.resume()
      }
      
  }
