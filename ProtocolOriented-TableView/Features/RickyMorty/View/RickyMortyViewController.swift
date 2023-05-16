//
//  RickyMortyViewController.swift
//  ProtocolOriented-TableView
//
//  Created by Barış Savaş on 10.05.2023.
//

import UIKit
import SnapKit

protocol RickyMortyOutput {
    func changeLoading(isLoad:Bool)
    func saveDatas(values:[Result])
}
final class RickyMortyViewController: UIViewController {
    private let labelTitle: UILabel = {
        let labelTitle = UILabel()
        labelTitle.text = "Rick and Morty"
        return labelTitle
    }()
    private let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let tableview: UITableView = UITableView()
    private lazy var results: [Result] = []
    lazy var viewModel: IRickyMortyViewModel = RickyMortyViewModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchItems()
        viewModel.setDelegate(output: self)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        configure()
    }
    
    private func configure() {
        view.addSubview(tableview)
        view.addSubview(labelTitle)
        view.addSubview(indicator)
        makeTableView()
        //makeLabelTitle()
    }
}
extension RickyMortyViewController: RickyMortyOutput{
    func changeLoading(isLoad: Bool) {
        isLoad ? indicator.startAnimating() : indicator.stopAnimating()
    }
    
    func saveDatas(values: [Result]) {
        results = values
        tableview.reloadData()
    }
}
extension RickyMortyViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier:TableViewCell.identifier) as? TableViewCell else {
            return UITableViewCell()
        }
        cell.saveModel(model: results[indexPath.row])
        return cell
    }
    
    
}
                                
extension RickyMortyViewController {
    private func makeLabelTitle(){
        labelTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(10)
        }
    }
    private func makeTableView(){
        tableview.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
