//
//  NetworkReachability.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import Alamofire

class NetworkReachability {
    
    static let shared = NetworkReachability()
    private let reachabilityManager = NetworkReachabilityManager()
    
    public var isReachable: Bool { return reachabilityManager?.isReachable ?? false }
    
    public func startNetworkReachability() {
        reachabilityManager?.startListening()
    }
}
