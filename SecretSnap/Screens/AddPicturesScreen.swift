//
//  AddPicturesScreen.swift
//  SecretSnap
//
//  Created by Egor Ilchenko on 6/1/24.
//

import UIKit
import SnapKit

class AddPicturesScreen: UIViewController {
    // MARK: - Property
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let backImage = UIImage(systemName: "arrow.uturn.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium))
        button.setImage(backImage, for: .normal)
        button.setTitle(" Back", for: .normal)
        return button
    }()
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(" Save", for: .normal)
        let saveImage = UIImage(systemName: "square.and.arrow.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium))
        button.setImage(saveImage, for: .normal)
        return button
    }()
    private let topButtonContainer: UIView = {
        let container = UIView()
        return container
    }()
    private let addPictureButton: UIButton = {
        let button = UIButton(type: .system)
        let plusImage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium))
        button.setImage(plusImage, for: .normal)
        return button
    }()
    private let addingСontainer: UIView = {
        let container = UIView()
        container.layer.cornerRadius = Offsets.cornerRadius
        container.backgroundColor = .lightGray
        return container
    }()
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let favoriteButtonContainer: UIView = {
        let container = UIView()
        return container
    }()
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        let saveImage = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
        button.setImage(saveImage, for: .normal)
        //button.setTitle("LIKE", for: .normal)
        return button
    }()
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        configuratUI()
        print(view.frame.height)
    }
    // MARK: - configuratUI, adding propertys
    private func configuratUI() {
        view.addSubview(topButtonContainer)
        topButtonContainer.addSubview(backButton)
        topButtonContainer.addSubview(saveButton)
        view.addSubview(addingСontainer)
        addingСontainer.addSubview(addPictureButton)
        view.addSubview(textField)
        view.addSubview(favoriteButtonContainer)
        favoriteButtonContainer.addSubview(favoriteButton)
        configuratNotifications()
        textField.delegate = self
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(recognizer)
        // MARK: - configuratUI, adding constraints
        topButtonContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(Offsets.topButtonContainerHeight)
        }
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.leftOffset)
            make.bottom.equalToSuperview().inset(Offsets.topButtonsBottomOffset)
        }
        saveButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Offsets.righttOffset)
            make.bottom.equalToSuperview().inset(Offsets.topButtonsBottomOffset)
        }
        addingСontainer.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.pictureSideOffset)
            make.right.equalToSuperview().inset(Offsets.pictureSideOffset)
            make.top.equalTo(topButtonContainer.snp.bottom)
            let addingСontainerHeight = view.frame.height / Offsets.ContentHeightCoefficient
            make.height.equalTo(addingСontainerHeight)
        }
        addPictureButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(addingСontainer.snp.bottom).offset(Offsets.textFieldOffset)
            make.left.equalToSuperview().offset(Offsets.textFieldOffset)
            make.right.equalToSuperview().inset(Offsets.textFieldOffset)
        }
        favoriteButtonContainer.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        favoriteButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        // MARK: - configuratUI, adding actions
        let backAction = UIAction  { _ in
            self.backButtonPushed()
        }
        let saveAction = UIAction { _ in
            self.saveButtonPushed()
        }
        let addAction = UIAction { _ in
            self.addButtonPushed()
        }
        let favoriteAction = UIAction { _ in
            self.favoriteButtonPushed()
        }
        backButton.addAction(backAction, for: .touchUpInside)
        saveButton.addAction(saveAction, for: .touchUpInside)
        addPictureButton.addAction(addAction, for: .touchUpInside)
        favoriteButton.addAction(favoriteAction, for: .touchUpInside)
    }
    // MARK: - Action functions
    private func backButtonPushed() {
        showAlertBackPushed()
       // navigationController?.popViewController(animated: true)
    }
    private func saveButtonPushed() {
        print("SAVE")
    }
    private func addButtonPushed() {
        print("ADD")
    }
    private func favoriteButtonPushed() {
        print("LIKE")
    }
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo,
              let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
              let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardFrame.height
        let offset = addingСontainer.frame.maxY - (view.frame.height - keyboardHeight) + textField.frame.height + Offsets.textFieldOffset
        
        textField.snp.updateConstraints { make in
            make.top.equalTo(addingСontainer.snp.bottom).inset(offset)
            make.left.equalToSuperview().offset(Offsets.textFieldEnterOffset)
            make.right.equalToSuperview().inset(Offsets.textFieldEnterOffset)
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
            
        }
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let info = notification.userInfo,
              let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
        textField.snp.updateConstraints { make in
            make.top.equalTo(addingСontainer.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(Offsets.textFieldOffset)
            make.right.equalToSuperview().inset(Offsets.textFieldOffset)
        }
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    @objc func hideKeyboard() {
        textField.resignFirstResponder()
    }
    private func configuratNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func showAlertBackPushed() {
        let alert = UIAlertController(title: "Do you want to leave without saving?", message: "All unsaved pictures will be lost!!!", preferredStyle: .alert)
        let leaveAction = UIAlertAction(title: "Leave", style: .destructive) { _ in
                self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(leaveAction)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
        let controller = ViewingScreen()
        self.navigationController?.pushViewController(controller, animated: true)
        }
        alert.addAction(saveAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
}
extension AddPicturesScreen: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
}
