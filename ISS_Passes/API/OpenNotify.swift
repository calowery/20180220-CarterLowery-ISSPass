//
//  OpenNotify.swift
//  ISS_Passes
//
//  Created by Carter Lowery on 2/19/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OpenNotify {
    
    static let shared = OpenNotify()
    
    private static let baseURL = "http://api.open-notify.org"
    private static let headers = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    /**
     Retrieve current position of the  ISS.
     
     - parameter completion:  Completion handler for request.
     
     - returns: ISSPosition Instance.
     */
    class func getISSPosition(completion: @escaping ((ISSPosition?) -> Void)) {
        
        let urlString = "\(baseURL)/iss-now.json"
        Alamofire.request(urlString, method: .get, headers: headers).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).dictionaryObject
                let dictionary:NSDictionary? = NSDictionary(dictionary: json!)
                
                let position = ISSPosition.init(dictionary: dictionary)
                completion(position)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    /**
     Retrieve a list of upcoming ISS passes for a specific GPS location.
     
     - parameter lat:  current latitude.
     - parameter lon:  current longitude.
     - parameter alt:  Optional. current altitude.
     - parameter completion:  Completion handler for request.
     
     - returns: Array of PassTime Instances.
     */
    class func getPassTimes(lat: Float, lon: Float, alt: Float?, completion: @escaping (_ result: [PassTime]) -> Void) {
        var urlString = "\(baseURL)/iss-pass.json"+"?lat=\(lat)"+"&lon=\(lon)"
        if let alttitude = alt{
            // alt param must be between 0 and 10,000
            if(1..<10000 ~= alttitude){
                urlString.append("&alt=\(alttitude)")
            }
        }
        
        Alamofire.request(urlString, method: .get, headers: headers).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).dictionaryValue
                let dictionary:NSArray? = json["response"]?.arrayObject as NSArray?
                
                let arrayofPassTimes = PassTime.modelsFromDictionaryArray(array: dictionary!)
                completion(arrayofPassTimes)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    /**
     Retrieve a the names and spacecraft of people currently in space.
     
     - parameter completion:  Completion handler for request.
     
     - returns: Array of SpaceMan Instances.
     */
    class func getSpaceMen(completion: @escaping (_ result: [SpaceMan]) -> Void) {
        let urlString = "\(baseURL)/astros.json"
        
        Alamofire.request(urlString, method: .get, headers: headers).validate().responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).dictionaryValue
                let dictionary:NSArray? = json["people"]?.arrayObject as NSArray?
                
                let arrayofSpacemen = SpaceMan.modelsFromDictionaryArray(array: dictionary!)
                completion(arrayofSpacemen)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
}
