//
//  StackLayoutViewController.swift
//  YogaFlexBoxKit
//
//  Created by Apple on 2019/6/3.
//  Copyright © 2019 zjade. All rights reserved.
//

import Foundation

class StackLayoutViewController: LayoutViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 30, y: 300, width: 100, height: 100))
        button.setTitle("button", for: .normal)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(touchButton), for: .touchUpInside)
        self.view.addSubview(button)
        stackLayout.lineSpace = 10
        stackLayout.itemSpace = 5
//        stackLayout.flexDirection = .column
//        stackLayout.justifyContent = .spaceAround
//        stackLayout.alignContent = .fill
//        stackLayout.itemEqual = .allSize
        stackLayout.lineLength = 3
        stackLayout.configureLayout { (yoga) in
            yoga.margin = 20
            //            yoga.height = 300
        }
        self.view.addChild(stackLayout)
        addGridLayout()
    }
    let stackLayout = GridLayout()
    func addGridLayout() {
        for i in 0..<11 {
            let label = UILabel()
            label.backgroundColor = UIColor.red
            label.text = "\(i)\(String.random(min: i + 1, max: i + 1))"
            if i == 1 {
                label.yoga.alignSelf = .stretch
            }
            if i == 3 {
                label.font = UIFont.systemFont(ofSize: 36)
            }
            stackLayout.addChild(label)
        }
        self.view
            .container(containerSize: self.view.frame.size)
            .applyLayout()
    }
    @objc func touchButton() {
        stackLayout.removeAllChild()
        addGridLayout()
    }
}
extension String {
    static let uppercaseLetters: String = "ABCDEFGHIGKLMNOPQRSTUVWXYZ"
    static let lowercaseLetters: String = "abcdefghigklmnopqrstuvwxyz"
    static let decimalDigits: String = "0123456789"
    
    static func random(min: Int, max: Int) -> String {
        guard max >= min else {return ""}
        guard min >= 0 else {return ""}
        let count = Int.random(in: min...max)
        return self.random(count: count)
    }
    /// ZJaDe: 随机数字加字母
    static func random(count: Int) -> String {
        let source = self.uppercaseLetters + self.lowercaseLetters + self.decimalDigits
        return _random(source: source, count: count)
    }
    /// ZJaDe: 随机数字
    static func randomNumber(count: Int) -> String {
        let source = self.decimalDigits
        return _random(source: source, count: count)
    }
    private static func _random(source: String, count: Int) -> String {
        var result: String = ""
        (0..<count).forEach { (_) in
            result.append(source[Int.random(in: 0..<source.count)])
        }
        return result
    }
    subscript(integerIndex: Int) -> Character {
        return self[index(startIndex, offsetBy: integerIndex)]
    }
}
