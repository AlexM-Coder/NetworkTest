//
//  DataFromJSON.swift
//  NetworkTest
//
//  Created by Алексей Муравьев on 27.05.2022.
//

import UIKit

protocol JsonDataProtocol {
    var id: Int { get set }
    var title: String { get set }
    var userID: Int { get set }
    var body: String { get set }
}

struct myDataItem: JsonDataProtocol {
    
    var id: Int
    
    var title: String
    
    var userID: Int
    
    var body: String
}


