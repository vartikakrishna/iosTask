//
//  supportFile.swift
//  iosTestDemo
//
//  Created by vartika krishna on 01/05/24.
//

import Foundation
import UIKit


//////////////////////////////////////////
// Cache Storage for Array
//////////////////////////////////////////

class CacheManager {
    static let shared = CacheManager()
    private let cache = NSCache<AnyObject, AnyObject>()

    private init() {
        // Initialize cache settings if needed
        cache.countLimit = 100 // Example limit of cached items
        cache.totalCostLimit = 1024 * 1024 // Example limit of total cached cost
    }

    func cacheArrayData(array: [Any], key: String) {
        // Cache the array object with a unique key
        cache.setObject(array as AnyObject, forKey: key as AnyObject)
    }

    func getArrayData(forKey key: String) -> [Any]? {
        // Retrieve the cached array object for a given key
        return cache.object(forKey: key as AnyObject) as? [Any]
    }
}

