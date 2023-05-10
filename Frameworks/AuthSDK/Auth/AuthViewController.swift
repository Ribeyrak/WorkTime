//
//  AuthViewController.swift
//  Pods
//
//  Created by Evhen Lukhtan on 13.04.2023.
//

import UIKit
import SnapKit
import UIComponents

public final class AuthViewController: BaseViewController {
    
    private let contentView = UIView()
    private let titleSwithView = WTTitleSwitchView()
    private let usernameTextFiled = WTAuthTextField()
    private let passwordTextField = WTAuthTextField()
    private let loginButton = UIButton()
    
    override public func setup() {
        super.setup()
        
        view.backgroundColor = .secondarySystemBackground
        
        setupContentView()
        setupTitleSwithView()
        setupLoginTextFiled()
        setupPasswordTextField()
        setupLoginButton()
    }
}

private extension AuthViewController {
    func setupContentView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.centerY.horizontalEdges.equalToSuperview()
        }
    }
    
    func setupTitleSwithView() {
        contentView.addSubview(titleSwithView)
        
        titleSwithView.titles = ("Login", "Sign Up")
        
        titleSwithView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(45)
        }
    }
    
    func setupLoginTextFiled() {
        contentView.addSubview(usernameTextFiled)
        
        usernameTextFiled.placeholder = "Username"
        
        usernameTextFiled.snp.makeConstraints {
            $0.top.equalTo(titleSwithView.snp.bottom).offset(58)
            $0.leading.equalToSuperview().inset(45)
            $0.height.equalTo(28)
        }
    }
    
    func setupPasswordTextField() {
        contentView.addSubview(passwordTextField)
        
        passwordTextField.placeholder = "Password"
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextFiled.snp.bottom).offset(58)
            $0.leading.equalToSuperview().inset(45)
            $0.height.equalTo(28)
        }
    }
    
    func setupLoginButton() {
        contentView.addSubview(loginButton)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue

        
        loginButton .snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(58)
            $0.trailing.equalToSuperview().inset(45)
            $0.bottom.equalToSuperview()
        }
    }
}
