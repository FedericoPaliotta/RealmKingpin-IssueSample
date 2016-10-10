//
//  AnnotationObj.swift
//  RealmKingpinSample
//
//  Created by Federico on 10/10/16.
//  Copyright © 2016 Posse. All rights reserved.
//

import Realm
import RealmSwift
import MapKit

class AnnotationObj : Object, MKAnnotation {
  
  let id = RealmOptional<Int>()
  
  dynamic var title: String?
  
  var coordinate: CLLocationCoordinate2D {
    let lat: Double = 38 + Double(arc4random_uniform(100000)) / 100000
    let lon: Double = -95 + Double(arc4random_uniform(100000)) / 100000
    print(lat); print(lon)
    return CLLocationCoordinate2D(latitude: lat, longitude: lon)
  }
  
  required init() {
    super.init()
  }
  
  required init(realm: RLMRealm, schema: RLMObjectSchema) {
    super.init(realm: realm, schema: schema)
  }
  
  required init(value: AnyObject, schema: RLMSchema) {
    super.init(value: value, schema: schema)
  }
  
  override static func primaryKey() -> String? {
    return "id"
  }

}