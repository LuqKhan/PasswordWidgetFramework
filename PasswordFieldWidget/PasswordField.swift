//
//  PasswordField.swift
//  passwordTextField
//
//  Created by Luqmaan Khan on 8/16/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import Foundation
import UIKit

public class PasswordField: UIControl {
    
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    private var passwordIsHidden: Bool = true
    var strengthLevel: String = ""
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    let passwordField = UITextField(frame: CGRect(x: 20, y: 35, width: 300, height: 50.0))
    private var showHidePasswordButton = UIButton(type: .custom)
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    
    func setup() {
        ///titlelabel
        titleLabel.text = "Enter Password"
        titleLabel.textColor = labelTextColor
        titleLabel.font = labelFont
        //textField
        passwordField.borderStyle = .roundedRect
        passwordField.layer.borderColor = textFieldBorderColor.cgColor
        passwordField.layer.borderWidth = 1.0
        passwordField.layer.cornerRadius = 5.0
        passwordField.addTarget(self, action: #selector(passwordCounter), for: .allEditingEvents)
        passwordField.delegate = self
        
        //strengthDescriptionLabel
        strengthDescriptionLabel.textColor = labelTextColor
        strengthDescriptionLabel.font = labelFont
        strengthDescriptionLabel.text = "Too Weak"
        //showPasswordButton
        showHidePasswordButton.frame = CGRect(x: 308, y: 43, width: 25, height: 25)
        showHidePasswordButton.addTarget(self, action: #selector(showHidePasswordButtonTapped), for: .touchUpInside)
        showHidePasswordButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        //weakMediumStrongViews
        weakView.backgroundColor = weakColor
        weakView.frame = CGRect(x: 25, y: 92, width: 60, height: 4)
        weakView.layer.cornerRadius = 5
        mediumView.backgroundColor = mediumColor
        mediumView.frame = CGRect(x: 87, y: 92, width: 60, height: 4)
        mediumView.layer.cornerRadius = 5
        strongView.backgroundColor = strongColor
        strongView.frame = CGRect(x: 149, y: 92, width: 60, height: 4)
        strongView.layer.cornerRadius = 5
        //addSubviews
        addSubview(strengthDescriptionLabel)
        addSubview(strongView)
        addSubview(weakView)
        addSubview(mediumView)
        addSubview(titleLabel)
        addSubview(passwordField)
        addSubview(showHidePasswordButton)
       //Constraints
        //label Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let leadingLabelConstraint = titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        let topLabelConstraint = titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        NSLayoutConstraint.activate([leadingLabelConstraint, topLabelConstraint])
        //passwordFIeldConstraints
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        let topPasswordFieldConstraint = passwordField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        let leadingPasswordFIeldConstraint = passwordField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        let trailingPasswordConstraint = passwordField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        NSLayoutConstraint.activate([topPasswordFieldConstraint, leadingPasswordFIeldConstraint, trailingPasswordConstraint])
        //strengthDescriptionLabelConstraints
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        let strengthLabelTopConstraint = strengthDescriptionLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10)
        let strengthLabelLeadingConstraint = strengthDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 250)
        NSLayoutConstraint.activate([strengthLabelTopConstraint, strengthLabelLeadingConstraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        self.backgroundColor = bgColor
        mediumView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        strongView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        passwordField.isSecureTextEntry = true
    }

    @objc func showHidePasswordButtonTapped() {
        passwordIsHidden = !passwordIsHidden
        if passwordIsHidden == true {
            showHidePasswordButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
            passwordField.isSecureTextEntry = true
        } else if passwordIsHidden == false {
            showHidePasswordButton.setImage(UIImage(named: "eyes-open"), for: .normal)
            passwordField.isSecureTextEntry = false
        }
    }
    
    @objc func passwordCounter() {
        guard let enteredPassword = passwordField.text, let strength = strengthDescriptionLabel.text else {return}
        self.password = enteredPassword
        self.strengthLevel = strength

        if passwordField.text != "", passwordField.text!.count > 0 &&  passwordField.text!.count < 9 {
            weakView.backgroundColor = weakColor
            strengthDescriptionLabel.text = "Too Weak"
            UIView.animate(withDuration: 1, animations: {
                self.weakView.frame = CGRect(x: 25, y: 92, width: 60, height: 11)
            }) { (nil) in
                UIView.animate(withDuration: 1, animations: {
                    self.weakView.frame = CGRect(x: 25, y: 92, width: 60, height: 4)
                })
                
            }
        
        } else if passwordField.text != "", passwordField.text!.count > 9 &&  passwordField.text!.count < 19 {
            mediumView.backgroundColor = mediumColor
            strengthDescriptionLabel.text = "Could Be Stronger"
            UIView.animate(withDuration: 1, animations: {
                self.mediumView.frame = CGRect(x: 87, y: 92, width: 60, height: 11)
            }) { (nil) in
                UIView.animate(withDuration: 1, animations: {
                    self.mediumView.frame = CGRect(x: 87, y: 92, width: 60, height: 4)
                })
                
            }
    } else if passwordField.text != "", passwordField.text!.count >= 19 {
        strongView.backgroundColor = strongColor
        mediumView.backgroundColor = mediumColor
        strengthDescriptionLabel.text = "Strong Password"
            UIView.animate(withDuration: 1, animations: {
                self.strongView.frame = CGRect(x: 149, y: 92, width: 60, height: 11)
            }) { (nil) in
                UIView.animate(withDuration: 1, animations: {
                    self.strongView.frame = CGRect(x: 149, y: 92, width: 60, height: 4)
                })
            }
        } else {
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            strongView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            strengthDescriptionLabel.text = "Too Weak"
        }
    }
}
extension PasswordField: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        return true
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        print("\(password), \(strengthLevel)")
        return true
    }
}
