//
//  LocationServiceDelegate.swift
//  URBN-codesample
//
//  Created by C4Q on 4/13/18.
//

import Foundation
import MapKit

//MARK: - Location Service Delegate Methods
extension SearchVC: LocationServiceDelegate {
    
    func locationServiceAuthorizationStatusChanged(toStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .denied:
            if self.presentedViewController == nil {
                let settingsAlert = Alerts.createAlert(withTitle: "Location Services Not Enabled", andMessage: "Please enable Location Services in Settings for better search results.")
                Alerts.addAction(withTitle: "Cancel", style: .cancel, toAlertController: settingsAlert, andCompletion: nil)
                Alerts.addAction(withTitle: "Settings", style: .default, toAlertController: settingsAlert) { (_) in
                    guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else {return}
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
                self.present(settingsAlert, animated: true, completion: nil)
            }
        case .restricted:
            let restrictedAlert = Alerts.createAlert(withTitle: "Warning", andMessage: "This app is not authorized to use location services.")
            Alerts.addAction(withTitle: "OK", style: .default, toAlertController: restrictedAlert, andCompletion: nil)
            self.present(restrictedAlert, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func userLocationUpdateFailed(withError error: Error) {
        let failedLocationAlert = Alerts.createAlert(withTitle: "Failed Location Authorization", andMessage: "Please enable Location Services in Settings or check network connectivity.")
        Alerts.addAction(withTitle: "OK", style: .default, toAlertController: failedLocationAlert, andCompletion: nil)
        self.present(failedLocationAlert, animated: true, completion: nil)
    }
    
    func userLocationUpdatedToLocation(_ location: CLLocation) {
        let userCoordinates = searchView.mapView.userLocation.coordinate
        
        if numberOfLaunches == 0 {
            searchView.mapView.showsUserLocation = true
            let regionRadius: CLLocationDistance = 10000
            let userRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                regionRadius, regionRadius)
            searchView.mapView.setRegion(userRegion, animated: true)
            numberOfLaunches += 1
        }
        
        LocationService.manager.getCurrentLocation(fromUserCoordinate: userCoordinates, completionHandler: {(currentLocation) in
            self.searchView.locationSearchBar.placeholder = currentLocation
            self.searchView.locationSearchBar.layoutIfNeeded()
        })
    }
}

