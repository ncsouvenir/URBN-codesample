//
//  MKMapViewDelegate.swift
//  URBN-codesample
//
//  Created by C4Q on 4/13/18.
//

import Foundation
import MapKit


extension SearchVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        let errorAlert = Alerts.createErrorAlert(withMessage: "Location not Enabled. Click on Locaiton button to enable location", andCompletion: nil)
        Alerts.addAction(withTitle: "OK", style: .default, toAlertController: errorAlert, andCompletion: nil)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let detailVC = DetailedVenueVC()
        detailVC.configureView(venue: venues[selectedIndex])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let selectedAnnotation = view.annotation else {return}
        guard let annotationIndex = annotations.index(where: { (annotation) -> Bool in
            (annotation.coordinate.latitude == selectedAnnotation.coordinate.latitude &&
                annotation.coordinate.longitude == selectedAnnotation.coordinate.longitude)
        }) else {return}
        selectedIndex = annotationIndex
    }
    
    //MARK: returns the view for each annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //if annotation is the user location, don't do anything
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "mapAnnotationView") as? MKMarkerAnnotationView
        //the bubble that pops up when you click the annotation
        annotationView?.canShowCallout = true
        annotationView?.annotation = annotation
        annotationView?.animatesWhenAdded = true
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        annotationView?.markerTintColor = UIColor.purple
        //annotation UI
        annotationView?.layer.shadowOpacity = 0.7
        annotationView?.layer.shadowColor = UIColor(displayP3Red: 0.67, green: 0.07, blue: 0.50, alpha: 0.8).cgColor
        annotationView?.layer.shadowOffset = CGSize.zero
        annotationView?.layer.shadowRadius = 7
        annotationView?.displayPriority = .required
        return annotationView
    }
}
