//
//  ProductListDataSource.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 07/11/2021.
//

import Foundation
import Alamofire
class ProductListDataSource{
    
    func getProducts(parameters:[String:Any],isSuccess:@escaping([Product]?)->Void,isError:@escaping(String?)->Void){
        
        //TODO CHECK Internet connection to detect whether to get data from Webservice or cached one
        
        Network.sharedInstance().getMethod(
            url: WEB_SERVICE.PRODUCTS,
            parameters: parameters,
            headers: nil,
            encoding: URLEncoding.default,
            isSuccess: { (products : [Product]?) in
                guard let products = products else {
                    isSuccess(nil)
                    return
                }
                isSuccess(products)
            },
            isError: {
                error in
                guard let error = error else {
                    isError(nil)
                    return
                }
                isError(error)
            }
        )
    }
    
}
