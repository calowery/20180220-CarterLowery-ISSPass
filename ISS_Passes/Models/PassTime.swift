//
//  PassTime.swift
//  ISS_Passes
//
//  Created by Carter Lowery on 2/19/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation

public class PassTime {
    public var risetime : String?
    public var duration : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of PassTime Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [PassTime]
    {
        var models:[PassTime] = []
        for item in array
        {
            models.append(PassTime(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: PassTime Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        risetime = "\(dictionary["risetime"] as! Double)"
        duration = "\(dictionary["duration"] as! Double) sec."

    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.risetime, forKey: "risetime")
        dictionary.setValue(self.duration, forKey: "duration")
        
        return dictionary
    }
    
}
