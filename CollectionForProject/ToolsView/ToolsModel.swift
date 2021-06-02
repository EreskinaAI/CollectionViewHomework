//
//  ToolsModel.swift
//  CollectionForProject
//
//  Created by Анна Ереськина on 02.06.2021.
//

import UIKit

/// Модель инструмента
class ToolsModel {
    /// Иконка
    var image: UIImage?
    /// Фигура
    var shape: DrawingShape
    
    /// Инициализатор
    /// - Parameters:
    ///   - image: картинка
    ///   - shape: инструмент
    init(image: UIImage?, shape: DrawingShape) {
        self.image = image
        self.shape = shape
    }
}

/// Тип фигуры для рисования
enum DrawingShape: String {
    // Овал
    case ellipse
    // Квадрат
    case quadrate
    // Жирная линия
    case randomLine
    // Треугольник
    case triangle
    // Линия
    case line
    // Квадрат с закругленными углами
    case roundedQuadrate
    // Круг
    case circle
}
