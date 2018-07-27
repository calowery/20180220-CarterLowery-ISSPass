//
//  ISSPosition.swift
//  ISS_Passes
//
//  Created by Carter Lowery on 2/19/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation

public class ISSPosition {
    private(set) var timestamp : String?
    private(set) var latitude : String?
    private(set) var longitude : String?

    /**
     Constructs the object based on the given dictionary.
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: ISSPosition Instance.
     */
    required public init?(dictionary: NSDictionary?) {
        
        timestamp = "\(dictionary?["timestamp"] as! Double)"
        if let iss_position = dictionary?["iss_position"] as! NSDictionary? {
            latitude = iss_position["latitude"] as? String
            longitude = iss_position["longitude"] as? String
        }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.timestamp, forKey: "timestamp")
        dictionary.setValue(self.latitude, forKey: "latitude")
        dictionary.setValue(self.longitude, forKey: "longitude")
        
        return dictionary
    }
    
}
