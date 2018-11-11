//
//  RestMoyaProvider.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import Alamofire
import Moya

enum RestAPI {
    case listAllTransactions
    case getTransaction(transactionId: Int)
}

extension RestAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://private-anon-a8518f0891-airbank.apiary-proxy.com/")!
    }
    
    var path: String {
        switch self {
        case .listAllTransactions:
            return "transactions"
        case let .getTransaction(transactionId):
            return "transactions/\(transactionId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listAllTransactions, .getTransaction:
            return .get
        }
    }
    
    var sampleData: Data {
        fatalError()
    }
    
    public var task: Task {
        return Task.requestParameters(parameters: [:], encoding: parameterEncoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .listAllTransactions, .getTransaction:
            return JSONEncoding()
        }
    }
}

extension RestAPI {
    static let restEndpointClosure = { (target: RestAPI) -> Endpoint in
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: [
                "Content-Type" : "application/json",
            ])
    }
}
