//
//  SpaceMan.swift
//  ISS_Passes
//
//  Created by Carter Lowery on 2/19/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import Foundation

public class SpaceMan {
    public var name : String?
    public var craft : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of SpaceMan Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [SpaceMan]
    {
        var models:[SpaceMan] = []
        for item in array
        {
            models.append(SpaceMan(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: SpaceMan Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        name = dictionary["name"] as? String
        craft = dictionary["craft"] as? String
        
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.craft, forKey: "craft")
        
        return dictionary
    }
    
}
