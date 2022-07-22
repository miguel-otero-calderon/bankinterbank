//
//  LoginViewController.swift
//  bankinterbank
//
//  Created by Miguel on 22/07/22.
//

import SafariServices
import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
}

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    var presenter: LoginPresenterProtocol?
    
    // Subviews
    private let headerView = LoginHeaderView()

    private let emailField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "User"
        field.keyboardType = .default
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
    }()

    private let passwordField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        return field
    }()

    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()

    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Terms of Service", for: .normal)
        return button
    }()

    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Privacy Policy", for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        addSubviews()

        emailField.delegate = self
        passwordField.delegate = self

        addButtonActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: (view.height - view.safeAreaInsets.top)/3
        )

        emailField.frame = CGRect(x: 25, y: headerView.bottom+20, width: view.width-50, height: 50)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-50, height: 50)
        signInButton.frame = CGRect(x: 35, y: passwordField.bottom+20, width: view.width-70, height: 50)

        termsButton.frame = CGRect(x: 35, y: signInButton.bottom+50, width: view.width-70, height: 40)
        privacyButton.frame = CGRect(x: 35, y: termsButton.bottom+10, width: view.width-70, height: 40)
    }

    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }

    private func addButtonActions() {
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacy), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func didTapSignIn() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let email = emailField.text,
              let password = passwordField.text else {
            return
        }
        
        let validation = LoginValidationsUseCase(login:
                                                    Login(username: "",
                                                                email: email,
                                                                password: password))
        if validation.getValidatedUser() != "" {
            emailField.text = ""
            emailField.becomeFirstResponder()
            return
        }
        if validation.getValidatedPassword() != "" {
            passwordField.text = ""
            passwordField.becomeFirstResponder()
            return
        }

        presenter?.signIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    HapticManager.shared.vibrate(for: .success)
                    let postViewController = PostWireFrame.createPostModule() as! PostViewController
                    postViewController.modalPresentationStyle = .fullScreen
                    self?.present(postViewController,animated: true,completion: nil)

                case .failure(let error):
                    HapticManager.shared.vibrate(for: .error)
                    print(error)
                }
            }
        }
    }

    @objc func didTapTerms() {
        guard let termsOfService = self.presenter?.getTermsOfService() else { return }
        guard let url = URL(string: termsOfService) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

    @objc func didTapPrivacy() {
        guard let privacyPolicy = self.presenter?.getPrivacyPolicy() else { return }
        guard let url = URL(string: privacyPolicy) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }

    // MARK: Field Delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapSignIn()
        }
        return true
    }
}

extension LoginViewController: LoginViewProtocol {
    // TODO: implement view output methods
}

