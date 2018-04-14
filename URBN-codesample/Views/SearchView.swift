//
//  SearchView.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import UIKit
import MapKit
import SnapKit


class SearchView: UIView {
    
    lazy var venueSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search a Venue"
        return searchBar
    }()
    
    lazy var locationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Queens NY"
        searchBar.barTintColor = .white
        return searchBar
    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    
    lazy var userTrackingButton: MKUserTrackingButton = {
        let trackingButton = MKUserTrackingButton(mapView: mapView)
        return trackingButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        backgroundColor = .purple
        setupViews()
    }
    
    private func setupViews() {
        let viewObjects = [venueSearchBar, locationSearchBar, mapView, userTrackingButton] as [UIView]
        viewObjects.forEach{addSubview($0)}
        
        locationSearchBar.snp.makeConstraints { (location) in
            location.top.leading.trailing.equalTo(self)
            location.height.equalTo(40)
        }
        mapView.snp.makeConstraints { (map) in
            map.top.equalTo(locationSearchBar.snp.bottom)
            map.trailing.leading.bottom.equalTo(self)
        }
        userTrackingButton.snp.makeConstraints { (tracking) in
            tracking.bottom.equalTo(mapView.snp.bottom).offset(-20)
            tracking.trailing.equalTo(self).offset(-30)
        }
    }
}


