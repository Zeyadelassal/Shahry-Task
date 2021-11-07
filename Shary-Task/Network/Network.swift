//
//  Network.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 07/11/2021.
//

import Foundation
import Alamofire

class Network{
    
    private init() {}
    
    class func sharedInstance()->Network{
        struct Singleton{
            static var shared = Network()
        }
        return Singleton.shared
    }
    
    func getMethod<T:Codable>(url:String,parameters:[String:Any]?,headers:[String:String]?,encoding:ParameterEncoding,isSuccess: @escaping(_ response:T?)->Void,isError:@escaping(String?)->Void){
        
        let urlHeaders = headers != nil ? HTTPHeaders(headers!) : nil
        let URL = WebService.BASE_URL + url
        AF.request(URL,parameters: parameters,encoding: encoding)
            .validate()
            .responseDecodable(of: T.self) { (response) in
                print("response \(response)")
                if let error = response.error {
                    isError(error.errorDescription)
                }else{
                    isSuccess(response.value)
                }
            }
    }
}
