//
//  DrawingCell.swift
//  CollectionForProject
//
//  Created by Анна Ереськина on 31.05.2021.
//

import UIKit
import Foundation

/// Ячейка отображающая инструмент
class DrawingCell: UICollectionViewCell {
    
    /// Модель данных
    weak var model: ToolsModel?
    
    /// Картинка инструмента
    lazy var contentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Обновление ячейки с новой моделью
    /// - Parameter model: модель данных
    func update(with model: ToolsModel) {
        self.model = model
        
        contentImage.image = model.image
    }
    
    /// Масштабируем размер ячейки и генерируем тактильную обратную связь, указывая на то, что выбрана центрированная ячейка
    func transformToLarge() {
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 1.3
            
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        }
    }
    
    /// Возврат размера ячейки в исходное состояние
    func transformToStandart() {
        UIView.animate(withDuration: 0.2) {
            self.layer.borderWidth = 0
            self.transform = CGAffineTransform.identity
        }
    }
    
    private func setupViews() {
        layer.cornerRadius = self.frame.height / 2.0

        contentView.addSubview(contentImage)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            contentImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            contentImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            contentImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
}
