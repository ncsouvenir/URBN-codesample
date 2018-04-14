//
//  DetailedVenueView.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import UIKit

class DetailedVenueView: UIView {
    
    lazy var DetailedVenueTableView: UITableView = {
        let tv = UITableView()
        tv.register(DetailedVenueTableViewCell.self, forCellReuseIdentifier: "DetailVenueCell")
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(DetailedVenueTableView)
        DetailedVenueTableView.snp.makeConstraints { (tableView) in
            tableView.edges.equalTo(self)
        }
    }
}
