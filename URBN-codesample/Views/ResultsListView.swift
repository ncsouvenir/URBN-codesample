//
//  ResultsListView.swift
//  URBN-codesample
//
//  Created by C4Q on 4/12/18.
//

import UIKit
import SnapKit

class ResultsListView: UIView {
    
    lazy var resultsListTableView: UITableView = {
        let tv = UITableView()
        tv.register(ResultsTableViewCell.self, forCellReuseIdentifier: "ResultsCell")
        tv.tableFooterView = UIView(frame: .zero) //gets rid of any empty rows
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
        addSubview(resultsListTableView)
        resultsListTableView.snp.makeConstraints { (tableView) in
            tableView.edges.equalTo(self)
        }
    }
}
