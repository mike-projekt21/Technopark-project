//
//  MainCollectionViewCell.swift
//  Technopark Project
//
//  Created by Vyacheslav Pronin on 21.05.2021.
//

import Foundation
import UIKit
import PinLayout

final class MainCollectionViewCell: UICollectionViewCell {
    
    private var succses = false
    private var vocabulary = false
    private var cellPosition = 0
    weak var delegate: MainDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .standartFont
        label.numberOfLines = 3
        label.textColor = .textColorLight
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .standartFont
        label.numberOfLines = 1
        label.textColor = .textColorLight
        return label
    }()
    
    private let iconSuccses: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fi-rr-check")
        imageView.image = imageView.image?.tinted(with: .iconColor)
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if succses == true {
            titleLabel.textColor = .successColor
            subTitleLabel.textColor = .successColor
            iconSuccses.image = iconSuccses.image?.tinted(with: .successColor)
        }
        
        titleLabel.pin
            .sizeToFit()
            .top(45)
            .hCenter()
        
        if vocabulary == true {
        subTitleLabel.pin
            .sizeToFit()
            .below(of: titleLabel)
            .margin(21)
            .hCenter()
        }
        
        if succses == true && vocabulary == true {
            iconSuccses.pin
                .size(24)
                .top(8)
                .right(12.5)
        }
    }
    
    func configure(with model: EducationalMaterial, model position: Int) {
        
        switch model {
        case .vocabulary(let vocobulary):
            titleLabel.text = vocobulary.name
            subTitleLabel.text = "\(vocobulary.progress)%"
            succses = vocobulary.succses
            vocabulary = true
            cellPosition = position
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openVocabularyViewController))
            self.addGestureRecognizer(gestureRecognizer)
        case .exercises(let exercises):
            titleLabel.text = exercises.name
            cellPosition = position
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openLessonViewController))
            self.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    private func setup() {
        [titleLabel, subTitleLabel, iconSuccses].forEach { addSubview($0) }
        
        layer.cornerRadius = 8
        backgroundColor = .buttonColor
        layer.shadowColor = UIColor.shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 4
    }
    
    @objc
    private func openVocabularyViewController(position: Int) {
        delegate?.openVocabularyViewController(position: cellPosition)
    }
    
    @objc
    private func openLessonViewController(position: Int) {
        delegate?.openLessonViewController(position: cellPosition)
    }
}

@objc
protocol  MainDelegate: AnyObject {
    @objc optional func newVocabularyController()
    @objc optional func newExercisesController()
    func openVocabularyViewController(position: Int)
    func openLessonViewController(position: Int)
}
