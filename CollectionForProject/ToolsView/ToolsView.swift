//
//  Tools.swift
//  CollectionForProject
//
//  Created by Анна Ереськина on 31.05.2021.
//

import UIKit

/// Протокол делегата ToolsView
protocol ToolsViewDelegate: AnyObject {

    /// Сообщаем о выборе инструмента
    /// - Parameter tool: выбранный иструмент
    func selected(tool: DrawingShape)
}

/// Вью с инструментами для рисования
class ToolsView: UIView {
    
    /// Делегат
    weak var delegate: ToolsViewDelegate?

    /// Центральная ячейка
    private var centerCell: DrawingCell?
    
    /// Массив моделей
    private var toolItems: [ToolsModel] = [
        ToolsModel(image: UIImage(named: "ellipse"), shape: .ellipse),
        ToolsModel(image: UIImage(named: "quadrate"), shape: .quadrate),
        ToolsModel(image: UIImage(named: "randomLine"), shape: .randomLine),
        ToolsModel(image: UIImage(named: "triangle"), shape: .triangle),
        ToolsModel(image: UIImage(named: "line"), shape: .line),
        ToolsModel(image: UIImage(named: "roundedQuadrate"), shape: .roundedQuadrate),
        ToolsModel(image: UIImage(named: "circle"), shape: .circle)
    ]
    
    /// Коллекция с items
    lazy var toolsCollection: UICollectionView = {
        // свой лайаут
        let layout = ToolsFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DrawingCell.self, forCellWithReuseIdentifier: "DrawingCell")
        
        return collectionView
    }()
    
    /// Вью правого градиента
    private let leftGradientView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    /// Настройка самого правого градиента
    private let leftGradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBackground.cgColor, UIColor.systemBackground.withAlphaComponent(0).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)

        return gradient
    }()
    
    /// Вью левого градиента
    private let rightGradientView: UIImageView = {
      let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    /// Настройка самого левого градиента
    private let rightGradient: CAGradientLayer = {
       let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemBackground.cgColor, UIColor.systemBackground.withAlphaComponent(0).cgColor]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        
        return gradient
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        setupViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Обновление лайаута вью
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Чтобы доскролливалось и не возвращалось обратно в центр
        let layoutMargins: CGFloat = toolsCollection.layoutMargins.left + toolsCollection.layoutMargins.right
        let sideInset = frame.width / 2 - layoutMargins
        toolsCollection.contentInset = UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
        
        self.leftGradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width / 8, height: self.bounds.height)
        self.rightGradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width / 8, height: self.bounds.height)
        
        // Находим IndexPath центрального элемента
        let indexPath = IndexPath(item: toolItems.count / 2, section: 0)
        
        // скролим нашу коллекцию до этого IndexPath
        toolsCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        // сообщаем делегату что выбрал пользователь
        delegate?.selected(tool: toolItems[indexPath.item].shape)
    }
}

//MARK: - USER METHODS

extension ToolsView {
    /// Добавление всех вью на общее вью
    private func setupViews() {
        self.frame = UIScreen.main.bounds
        self.addSubview(toolsCollection)
        
        self.addSubview(leftGradientView)
        self.leftGradient.removeFromSuperlayer()
        self.leftGradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width / 8, height: self.bounds.height)
        self.leftGradientView.layer.addSublayer(leftGradient)
            
        self.addSubview(rightGradientView)
        self.rightGradient.removeFromSuperlayer()
        self.rightGradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width / 8, height: self.bounds.height)
        self.rightGradientView.layer.addSublayer(rightGradient)
        
    }
    
    /// Констрейнты для всех вью
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            toolsCollection.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            toolsCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            toolsCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            toolsCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            leftGradientView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            leftGradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            leftGradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            leftGradientView.widthAnchor.constraint(equalToConstant: 20),
        
            rightGradientView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            rightGradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            rightGradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            rightGradientView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension ToolsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        toolItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrawingCell", for: indexPath) as? DrawingCell ?? DrawingCell()
        
        cell.update(with: toolItems[indexPath.item])

        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ToolsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // скролим нашу коллекцию до выбранного IndexPath
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        // сообщаем делегату что выбрал пользователь
        delegate?.selected(tool: toolItems[indexPath.item].shape)
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView is UICollectionView else { return }
        
        let centerPoint = CGPoint(x: toolsCollection.frame.size.width / 2 + scrollView.contentOffset.x,
                                  y: toolsCollection.frame.size.height / 2 + scrollView.contentOffset.y)
        
        if let cell = centerCell {
            let offsetX = centerPoint.x - cell.center.x
            
            if  offsetX < -20 || offsetX > 20 {
                cell.transformToStandart()
                centerCell = nil
            }
        }

        /// Вычисляем ячейку по центру collectionView
        if let indexPath = toolsCollection.indexPathForItem(at: centerPoint), centerCell == nil {
            centerCell = toolsCollection.cellForItem(at: indexPath) as? DrawingCell
            centerCell?.transformToLarge()
            
            delegate?.selected(tool: toolItems[indexPath.item].shape)
        }
    }
}
