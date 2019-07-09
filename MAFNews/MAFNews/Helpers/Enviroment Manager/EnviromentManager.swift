//
//  EnviromentManager.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import Foundation
enum EnviromentType : String{

     case Production

    var baseURL : String {
        switch self {
         case .Production:
            return kProductionEndPoint
        }
    }
}

class EnviromentManager
{
    private var currentEnviroment : EnviromentType = .Production

    static var shared = EnviromentManager()

    var BaseURL : String {
        get {
            return self.currentEnviroment.baseURL
        }
    }

    class func intialize(enviroment:EnviromentType){
        shared.currentEnviroment = enviroment
    }
}
