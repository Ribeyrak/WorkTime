//
//  WTTitleSwitchView.swift
//  UIComponents
//
//  Created by Evhen Lukhtan on 10.05.2023.
//

import UIKit
import SnapKit

extension WTTitleSwitchView {
    public enum ActivityState {
        case left
        case right
    }
}

open class WTTitleSwitchView: BaseView {
    
    private let leftButton = UIButton()
    private let buttonSeparatorView = UILabel()
    private let rightButton = UIButton()
    
    private let animateTimeInterval: TimeInterval = 0.3
    
    public var state = ActivityState.left {
        didSet {
            animateStateSetting()
        }
    }
    
    public var titles: (leftTitle: String, rightTitle: String)? = nil {
        didSet {
            leftButton.setTitle(titles?.leftTitle, for: .normal)
            rightButton.setTitle(titles?.rightTitle, for: .normal)
        }
    }
    
    override func setup() {
        super.setup()
        
        setupLeftButton()
        setupButtonSeparatorView()
        setupRightButton()
    }
}

// MARK: - Setup UI
private extension WTTitleSwitchView {
    func setupLeftButton() {
        addSubview(leftButton)
        
        leftButton.setTitleColor(.black, for: .normal)
        leftButton.addTarget(self, action: #selector(leftButtonHandler), for: .touchUpInside)
        
        leftButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
    func setupButtonSeparatorView() {
        addSubview(buttonSeparatorView)
        
        buttonSeparatorView.text = "/"
        
        buttonSeparatorView.snp.makeConstraints {
            $0.centerY.equalTo(leftButton)
            $0.leading.equalTo(leftButton.snp.trailing).offset(5)
        }
    }
    
    func setupRightButton() {
        addSubview(rightButton)
        
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.addTarget(self, action: #selector(rightButtonHandler), for: .touchUpInside)
        rightButton.alpha = 0.3
        
        rightButton.snp.makeConstraints {
            $0.leading.equalTo(buttonSeparatorView.snp.trailing).offset(5)
            $0.trailing.verticalEdges.equalToSuperview()
        }
    }
}

public extension WTTitleSwitchView {
    @IBAction func leftButtonHandler() {
        if state == .right {
            state = .left
            print("leftButtonHandler")
        }
    }
    
    @IBAction func rightButtonHandler() {
        if state == .left {
            state = .right
            print("rightButtonHandler")
        }
    }
}

private extension WTTitleSwitchView {
    func animateStateSetting() {
        let activeButton = state == .left ? rightButton : leftButton
        let inactiveButton = state == .left ? leftButton : rightButton
        
        UIView.animate(withDuration: animateTimeInterval / 2) { // Reset alpha
            activeButton.alpha = 0.3
            self.buttonSeparatorView.alpha = 0.3
            
        } completion: { _ in
            UIView.animate(withDuration: self.animateTimeInterval) { // Set position
                self.buttonSeparatorView.alpha = 1
                inactiveButton.alpha = 1
                
                inactiveButton.snp.remakeConstraints {
                    $0.verticalEdges.leading.equalToSuperview()
                }
                
                self.buttonSeparatorView.snp.remakeConstraints {
                    $0.centerY.equalTo(inactiveButton)
                    $0.leading.equalTo(inactiveButton.snp.trailing).offset(5)
                }
                
                activeButton.snp.remakeConstraints {
                    $0.verticalEdges.trailing.equalToSuperview()
                    $0.leading.equalTo(self.buttonSeparatorView.snp.trailing).offset(5)
                }
                self.layoutIfNeeded()
                
            } completion: { _ in
                UIView.animate(withDuration: self.animateTimeInterval / 2) { // Set alpha
                    self.buttonSeparatorView.alpha = 1
                    inactiveButton.alpha = 1
                }
            }
        }
    }
}
