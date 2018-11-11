//
//  AppAssembly.swift
//  ABX
//
//  Created by Smartbox on 11/11/2018.
//  Copyright © 2018 ABX. All rights reserved.
//

import Foundation
import Swinject
import Moya

class AppAssembly {
    
    let container = Container()
    
    func assemble() {
        providersAssembly()
        
        TransactionsAssembly().assemble(container: container)
    }
    
    func providersAssembly() {
        container.register(DataService.self) { r in
            DataServiceImpl(
                restProvider: MoyaProvider(
                    endpointClosure: RestAPI.restEndpointClosure,
                    plugins: [NetworkLoggerPlugin(verbose: true)]
                )
            )
        }
    }
}
