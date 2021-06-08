//
//  TableWordViewCell.swift
//  Technopark Project
//
//  Created by Vyacheslav Pronin on 25.05.2021.
//

import Foundation
import UIKit
import PinLayout

final class TableWordViewCell: UITableViewCell {
    
    private let wordLabel: UILabel = {
        let label = UILabel()
        label.font = .standartFont
        label.textAlignment = .left
        label.textColor = .textColorLight
        label.numberOfLines = 1
        return label
    }()
    
    private let translationWordLabel: UILabel = {
        let label = UILabel()
        label.font = .smallLabelFont
        label.textAlignment = .left
        label.textColor = .textColorLight
        label.numberOfLines = 1
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .textColorLight
        view.layer.cornerRadius = 2.3
        return view
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .viewColor
        view.layer.cornerRadius = 0.5
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Word) {
        wordLabel.text = model.name
        translationWordLabel.text = model.translation
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lineView.pin
            .left(6)
            .right(1)
            .bottom()
            .height(1)
        
        wordLabel.pin
            .left(15)
            .bottom(7)
            .sizeToFit()
        
        separatorView.pin
            .bottom(8.5)
            .after(of: wordLabel)
            .marginHorizontal(26)
            .height(4.6)
            .width(27.5)
        
        translationWordLabel.pin
            .bottom(8)
            .after(of: separatorView)
            .marginHorizontal(29.5)
            .sizeToFit()
    }
    
    private func setup() {
        [wordLabel, translationWordLabel, separatorView, lineView].forEach { addSubview($0) }
    }
}
