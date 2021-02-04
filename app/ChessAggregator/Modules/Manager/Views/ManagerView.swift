//
// Created by Иван Лизогуб on 28.12.2020.
//

import UIKit

class ManagerView: AutoLayoutView {

    private var previewStack = ScrollableStackView(config: .defaultVertical)
    private let manageButton = UIButton(type: .system)
    private var headerCloud: HeaderCloudView
    var footerCloud: FooterCloudView
    let startList: StableTableView // TODO: add shadow and corner radius

    var onTapManageButton: (() -> Void)?

    init(event: Tournament, onTapSite: (() -> Void)?) {
        headerCloud = HeaderCloudView(event: event)
        footerCloud = FooterCloudView(event: event)
        footerCloud.siteTapAction = onTapSite
        startList = StableTableView(frame: .zero, style: .plain)
        super.init(frame: .zero)
        backgroundColor = .white
        setupList()
        setupButton()
        setupStack()
        setupConstraints()
    }

    required init(coder: NSCoder) {
        fatalError("not supported")
    }

    private func setupList() {
        startList.isScrollEnabled = false
        startList.backgroundColor = .white
        startList.allowsSelection = false

    }

    private func setupStack() {
        let topPadding = UIView()
        topPadding.heightAnchor.constraint(equalToConstant: 16).isActive = true

        previewStack = ScrollableStackView(config: .defaultVertical)
        previewStack.addArrangedSubview(topPadding)
        previewStack.addArrangedSubview(headerCloud)
        previewStack.addArrangedSubview(footerCloud)
        previewStack.addArrangedSubview(manageButton)
        previewStack.addArrangedSubview(startList)

        previewStack.config.stack.distribution = .fill
        previewStack.config.stack.alignment = .center
        previewStack.config.stack.spacing = 24
        previewStack.setCustomSpacing(0, after: topPadding)


        addSubview(previewStack)
    }

    func setupButton() {
        manageButton.backgroundColor = Styles.Color.buttonBlue
        manageButton.layer.cornerRadius = 15
        manageButton.layer.shadowRadius = 7
        manageButton.layer.shadowOffset = .zero
        manageButton.layer.shadowColor = manageButton.backgroundColor!.cgColor
        manageButton.layer.shadowOpacity = 1

        let applyAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font : UIFont(name: "AppleSDGothicNeo-Medium", size: 18)!,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        manageButton.addTarget(self, action: #selector(onTapManage), for: .touchUpInside)
        manageButton.setAttributedTitle(NSAttributedString(string: "Управлять", attributes: applyAttribute), for: .normal)
    }

    override func setupConstraints() {
        super.setupConstraints()

        NSLayoutConstraint.activate([
            headerCloud.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerCloud.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            footerCloud.leadingAnchor.constraint(equalTo: headerCloud.leadingAnchor),
            footerCloud.trailingAnchor.constraint(equalTo: headerCloud.trailingAnchor),

            manageButton.heightAnchor.constraint(equalToConstant: 50),
            manageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            manageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            startList.leadingAnchor.constraint(equalTo: previewStack.leadingAnchor),
            startList.trailingAnchor.constraint(equalTo: previewStack.trailingAnchor),

            previewStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            previewStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            previewStack.topAnchor.constraint(equalTo: topAnchor),
            previewStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

    }

    @objc private func onTapManage() {
        onTapManageButton?()
    }

    func updateView(event: Tournament) {
        previewStack.removeFromSuperview()
        headerCloud = HeaderCloudView(event: event)
        footerCloud = FooterCloudView(event: event)
        setupStack()
        setupConstraints()
    }

}
