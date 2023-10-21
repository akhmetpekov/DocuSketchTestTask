//
//  CustomCell.swift
//  DocuSketchTestTask
//
//  Created by Erik on 21.10.2023.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    static let identifier = "custom cell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let completeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        button.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(text: String) {
        label.text = text
    }
    
    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
        contentView.addSubview(completeButton)
    }
    
    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        completeButton.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    @objc private func checkBoxTapped() {
        completeButton.isSelected = !completeButton.isSelected
        if completeButton.isSelected {
            contentView.backgroundColor = .systemGreen
        } else {
            contentView.backgroundColor = .systemBackground
        }
    }
    
    
}
