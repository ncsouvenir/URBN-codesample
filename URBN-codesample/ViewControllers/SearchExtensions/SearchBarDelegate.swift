//
//  SearchBarDelegate.swift
//  URBN-codesample
//
//  Created by C4Q on 4/13/18.
//

import UIKit

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard
            let venueSearchText = venueSearchBarController.searchBar.text,
            !venueSearchText.isEmpty,
            let formattedVenueSearchText = venueSearchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            else {
                let noVenuesAlert = Alerts.createAlert(withTitle: "No Search Term", andMessage: "Please enter a valid search term before searching.")
                self.present(noVenuesAlert, animated: true, completion: nil)
                return
        }
        
        guard let locationSearchText = searchView.locationSearchBar.text,
            !locationSearchText.isEmpty else {
                
                let locationService = LocationService.manager.checkAuthorizationStatusAndLocationServices()
                
                if locationService.locationServicesEnabled && (locationService.authorizationStatus == .authorizedAlways || locationService.authorizationStatus == .authorizedWhenInUse) {
                    //if user location access is allowed search for venues
                    let userLocation = searchView.mapView.userLocation
                    getVenues(fromSearchTerm: formattedVenueSearchText, latitude: userLocation.coordinate.latitude, andLongitude: userLocation.coordinate.longitude)
                } else {
                    let settingsAlert = Alerts.createAlert(withTitle: "Location Services Not Enabled", andMessage: "Please enable Location Services in Settings for better search results.")
                    Alerts.addAction(withTitle: "OK", style: .default, toAlertController: settingsAlert, andCompletion: nil)
                    self.present(settingsAlert, animated: true, completion: nil)
                }
                return
        }
        
        //Get venue from location user enters in
        LocationService.manager.getLatAndLong(fromLocation: locationSearchText) { (error, coordinate) in
            if let error = error {
                let errorAlert = Alerts.createErrorAlert(withMessage: "Could not get coordinates from user-input location: \(error.localizedDescription)", andCompletion: nil)
                self.present(errorAlert, animated: true, completion: nil)
                return
            }
            if let coordinate = coordinate {
                self.getVenues(fromSearchTerm: formattedVenueSearchText, latitude: coordinate.latitude, andLongitude: coordinate.longitude)
                UserPreferences.manager.saveSearchCoordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)
            }
        }
        searchBar.resignFirstResponder()
    }
}

