//
//  ProductListDataSource.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 07/11/2021.
//

import Foundation
import Alamofire
class ProductListDataSource{
    
    
    func getProducts(){
        
        Network.sharedInstance().getMethod(
            url: WebService.PRODUCTS,
            parameters: ["limit":7],
            headers: nil,
            encoding: URLEncoding.default,
            isSuccess: { (products : [Product]?) in},
            isError: {error in}
            
        )
    }
    
}
