//
//  NetworkManager.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    private var weatherRequestType: WeatherRequestType
    private var parameters: Parameters
    
    init(weatherRequestType: WeatherRequestType, parameters: Parameters) {
        self.weatherRequestType = weatherRequestType
        self.parameters = parameters
    }
    
    // MARK: - Alamofire gets data and decodable class decoding JSON
    
    func get<T: Decodable>(method: HTTPMethod = .get, headers: HTTPHeaders? = nil, type: T.Type?, completionHandler: @escaping(T?) -> ()) {
        guard NetworkReachability.shared.isReachable else {
            showStatusBarAlert(title: "noInternetConnection".localized)
            completionHandler(nil)
            return
        }
        
        Alamofire.request(APIConfigurations.baseUrl+weatherRequestType.rawValue, method: method, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            guard let data = response.data else {
                showStatusBarAlert(title: "weatherDataCannotFetched".localized)
                completionHandler(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(T.self, from: data)
                completionHandler(json)
            }catch let error {
                showStatusBarAlert(title: error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
}
