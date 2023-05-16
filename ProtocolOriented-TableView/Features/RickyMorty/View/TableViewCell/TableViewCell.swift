//
//  TableViewCell.swift
//  ProtocolOriented-TableView
//
//  Created by Barış Savaş on 14.05.2023.
//

import UIKit
import AlamofireImage

class TableViewCell: UITableViewCell {
    
    private let customImageView:UIImageView = UIImageView()
    private let title: UILabel = UILabel()
    private let randomImage: String = "https://picsum.photos/200/300"
    static let identifier: String = "TableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func saveModel(model: Result){
        title.text = model.name
        customImageView.af.setImage(withURL: URL(string: model.image ?? randomImage) ?? URL(string: randomImage)!)
    }
    private func configure(){
        addSubview(customImageView)
        addSubview(title)
        
        customImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(50)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(customImageView.snp.top)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
        }
    }
}
