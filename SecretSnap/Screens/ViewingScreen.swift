//
//  ViewingScreen.swift
//  SecretSnap
//
//  Created by Egor Ilchenko on 6/1/24.
//

import UIKit
import SnapKit

class ViewingScreen: UIViewController {
    // MARK: - Property
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let backImage = UIImage(systemName: "arrow.uturn.backward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium))
        button.setImage(backImage, for: .normal)
        button.setTitle(" Back", for: .normal)
        return button
    }()
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        let saveImage = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium))
        button.setImage(saveImage, for: .normal)
        button.setTitle("Add to favorits", for: .normal)
        return button
    }()
    private let topButtonContainer: UIView = {
        let container = UIView()
        return container
    }()
    private let leftButton: UIButton = {
        let button = UIButton(type: .system)
        let leftImage = UIImage(systemName: "arrowshape.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
        button.setImage(leftImage, for: .normal)
        return button
    }()
    private let rightButton: UIButton = {
        let button = UIButton(type: .system)
        let leftImage = UIImage(systemName: "arrowshape.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium))
        button.setImage(leftImage, for: .normal)
        return button
    }()
    private let bottomButtonContainer: UIView = {
        let container = UIView()
        return container
    }()
    private let pictureСontainer: UIView = {
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
    enum Direction{
        case left
        case right
    }
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        configuratUI()
    }
    // MARK: - configuratUI, adding propertys
    private func configuratUI() {
        configuratNotifications()
        view.addSubview(topButtonContainer)
        topButtonContainer.addSubview(backButton)
        topButtonContainer.addSubview(favoriteButton)
        view.addSubview(bottomButtonContainer)
        bottomButtonContainer.addSubview(leftButton)
        bottomButtonContainer.addSubview(rightButton)
        view.addSubview(pictureСontainer)
        view.addSubview(textField)
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
        favoriteButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Offsets.righttOffset)
            make.bottom.equalToSuperview().inset(Offsets.topButtonsBottomOffset)
        }
        bottomButtonContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(Offsets.bottomButtonContainerHeight)
        }
        leftButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.leftOffset)
            make.centerY.equalToSuperview()
        }
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Offsets.righttOffset)
            make.centerY.equalToSuperview()
        }
        pictureСontainer.snp.makeConstraints { make in
            make.top.equalTo(topButtonContainer.snp.bottom)
            make.left.equalToSuperview().offset(Offsets.pictureSideOffset)
            make.right.equalToSuperview().inset(Offsets.pictureSideOffset)
            let pictureСontainerHeight = view.frame.height / Offsets.ContentHeightCoefficient
            make.height.equalTo(pictureСontainerHeight)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(pictureСontainer.snp.bottom).offset(Offsets.textFieldOffset)
            make.left.equalToSuperview().offset(Offsets.textFieldOffset)
            make.right.equalToSuperview().inset(Offsets.textFieldOffset)
        }
        // MARK: - configuratUI, adding actions
        let backAction = UIAction { _ in
            self.backButtonPushed()
        }
        let favoriteAction = UIAction { _ in
            self.favoriteButtonPushed()
        }
        let leftMoveAction = UIAction { _ in
            self.movingPictures(to: .left)
        }
        let rightMoveAction = UIAction { _ in
            self.movingPictures(to: .right)
        }
        backButton.addAction(backAction, for: .touchUpInside)
        favoriteButton.addAction(favoriteAction, for: .touchUpInside)
        leftButton.addAction(leftMoveAction, for: .touchUpInside)
        rightButton.addAction(rightMoveAction, for: .touchUpInside)
    }
    // MARK: - Action functions
    private func backButtonPushed() {
        navigationController?.popToRootViewController(animated: true)
    }
    private func favoriteButtonPushed() {
        print("LIKE")
    }
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let info = notification.userInfo,
              let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
              let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardFrame.height
        let offset = pictureСontainer.frame.maxY - (view.frame.height - keyboardHeight) + textField.frame.height + Offsets.textFieldOffset
        textField.snp.updateConstraints { make in
            make.top.equalTo(pictureСontainer.snp.bottom).inset(offset)
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
            make.top.equalTo(pictureСontainer.snp.bottom).offset(Offsets.textFieldOffset)
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
    private func movingPictures(to direction: Direction) {
        switch direction {
        case.left : print("left")
        case.right : print("right")
        }
    }
}
extension ViewingScreen: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
}

