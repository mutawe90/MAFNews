//
//  APIError.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import Foundation
class APIError: NSObject
{
    var message : String = "an error has occurred please try again"
    var extraDescription : String?
    var responseStatusCode : Int?
    var response : Any?
    var error : Error?

}
