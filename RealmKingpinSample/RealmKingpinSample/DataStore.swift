//
//  DataStore.swift
//  RealmKingpinSample
//
//  Created by Federico on 10/10/16.
//  Copyright © 2016 Posse. All rights reserved.
//

import Foundation
import RealmSwift

final class DataStore {
  
  private init() {}
  
  private static let singleton = DataStore()
  
  class func sharedInstance() -> DataStore {
    return singleton
  }
 
  
  func persist(object: Object) -> Bool {
    do {
      let realm = try Realm()
      try realm.write() {
        realm.add(object, update: true)
      }
      return true
    } catch let error as NSError {
        print("Realm Failure: \(error.localizedDescription)")
      return false
    }
  }
  
  
  func fetchAnnotations(params: [String : AnyObject]?, callback: ((annotations:[AnnotationObj]?) throws ->())?) {
    getAnnotations(params: params,
    success: { (annotations) in
      if let annotations = annotations {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0)) {
          for annotation in annotations {
            self.persist(annotation)
          }
        }
        do {
          try callback?(annotations: annotations)
        } catch let error as NSError {
            print("Realm Failure: \(error.localizedDescription)")
        }
      }
    },
    failure: { (error) in
      print("Failure \(error.localizedDescription)")
    })
  }
  
  func getAnnotations(params params: [String : AnyObject]?, success: (annotations: [AnnotationObj]?) -> (), failure: (error: NSError!) -> ()) {
    var annotations = [AnnotationObj]()
    for id in 0...1000 {
      let annotation = AnnotationObj()
      annotation.id.value = id
      annotations.append(annotation)
    }
    success(annotations: annotations)
  }
}

 