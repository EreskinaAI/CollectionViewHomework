//
//  ViewController.swift
//  CollectionForProject
//
//  Created by Анна Ереськина on 31.05.2021.
//

import UIKit

/// Контроллер для рисования
class DrawingViewController: UIViewController {
    
    /// Текущий выбранный инструмент
    private var currentTool: DrawingShape = .randomLine
    
    /// Вью с инструментами
    lazy var toolsView: ToolsView = {
        let toolsView = ToolsView()
        toolsView.translatesAutoresizingMaskIntoConstraints = false
        toolsView.delegate = self
        return toolsView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        makeConstraints()
    }
    
    /// Метод рисования
    func draw() {
        switch currentTool {
        case .randomLine:
            print("boldLine")
        case .circle:
            print("circle")
        case .ellipse:
            print("ellipse")
        case .line:
            print("line")
        case .quadrate:
            print("quadrate")
        case .roundedQuadrate:
            print("roundedQuadrate")
        case .triangle:
            print("triangle")
        }
    }
}

//MARK:- USER METHODS

extension DrawingViewController {
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(toolsView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            toolsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            toolsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toolsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toolsView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

//MARK: - ToolsViewDelegate
extension DrawingViewController: ToolsViewDelegate {
    func selected(tool: DrawingShape) {
        currentTool = tool
    }
}
