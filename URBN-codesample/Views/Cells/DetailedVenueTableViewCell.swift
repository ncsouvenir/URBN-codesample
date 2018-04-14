//
//  DetailedVenueTableViewCell.swift
//  URBN-codesample
//
//  Created by C4Q on 4/13/18.
//

import UIKit

class DetailedVenueTableViewCell: UITableViewCell {
    
    lazy var venueImage: UIImageView = {
        let venueImage = UIImageView()
        return venueImage
    }()
    
    lazy var detailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "DetailVenueCell")
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        addSubview(venueImage)
        addSubview(detailDescriptionLabel)
        
        venueImage.snp.makeConstraints { (image) in
            image.edges.equalTo(self)
        }
        detailDescriptionLabel.snp.makeConstraints { (label) in
            label.top.equalTo(venueImage.snp.bottom).offset(15)
            label.trailing.leading.equalTo(self)
            label.centerY.equalTo(self)
            label.height.equalTo(80)
        }
    }
}


