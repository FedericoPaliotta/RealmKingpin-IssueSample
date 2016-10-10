//
//  ViewController.swift
//  RealmKingpinSample
//
//  Created by Federico on 10/10/16.
//  Copyright © 2016 Posse. All rights reserved.
//

import UIKit
import MapKit
import kingpin
import RealmSwift

class ViewController: UIViewController, MKMapViewDelegate {

  let dataStore = DataStore.sharedInstance()
  var clusteringController: KPClusteringController!
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
    clusteringController = KPClusteringController(mapView: mapView,
                   clusteringAlgorithm: KPGridClusteringAlgorithm())
    setupAnnotationsData(params: nil)
  }

  func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    clusteringController.refresh(true, force: true)
  }
  
  private func setupAnnotationsData(params params: [String : AnyObject]?) {
    dataStore.fetchAnnotations(params) { [weak self] annotations in
      if let annotations = annotations {
        self?.clusteringController.setAnnotations(annotations)
      }
    }
  }

}

