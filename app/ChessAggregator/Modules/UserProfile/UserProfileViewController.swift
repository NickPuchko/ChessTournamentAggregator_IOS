

import UIKit

final class UserProfileViewController: UIViewController {
	private let output: UserProfileViewOutput

    var imageView: UIImageView
    var userImage = UIImage(imageLiteralResourceName: "vaultBoy")
    let userName = UILabel()
    let userStatus = UILabel()
    let userRating = UILabel()
    let editButton = UIButton(type: .system)
    let topView = UIView()
    let createButton = UIButton(type: .system)
    let myEventsButton = UIButton(type: .custom)
    let statisticsButton = UIButton(type: .custom)
    let fideButton = UIButton(type: .custom)
    let frcButton = UIButton(type: .custom)
    let logout = UIButton(type: .custom)

    private lazy var profileStack = ScrollableStackView(config: .defaultVertical)

    init(output: UserProfileViewOutput) {
        self.output = output
        imageView = UIImageView(image: userImage)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        topView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        profileStack.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        userRating.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        myEventsButton.translatesAutoresizingMaskIntoConstraints = false
        statisticsButton.translatesAutoresizingMaskIntoConstraints = false
        fideButton.translatesAutoresizingMaskIntoConstraints = false
        frcButton.translatesAutoresizingMaskIntoConstraints = false
        userStatus.translatesAutoresizingMaskIntoConstraints = false

        topView.backgroundColor = .white
        topView.addSubview(imageView)
        topView.addSubview(userName)
        topView.addSubview(userStatus)
        topView.addSubview(userRating)
        topView.addSubview(editButton)

        let myEventsBackground = ProfileRaw(name: "Мои турниры")
        myEventsButton.addSubview(myEventsBackground)

        let statisticsBackground = ProfileRaw(name: "Статистика")
        statisticsButton.addSubview(statisticsBackground)

        let fideBackground = ProfileRaw(name: "Профиль FIDE")
        fideButton.addSubview(fideBackground)

        let frcBackground = ProfileRaw(name: "Профиль ФШР")
        frcButton.addSubview(frcBackground)
        
        let logoutBackground = ProfileRaw(name: "Выйти")
        logout.addSubview(logoutBackground)
        
        profileStack.addArrangedSubview(createButton)
        profileStack.addArrangedSubview(myEventsButton)
        profileStack.addArrangedSubview(statisticsButton)
        profileStack.addArrangedSubview(fideButton)
        profileStack.addArrangedSubview(frcButton)
        profileStack.addArrangedSubview(logout)
        profileStack.backgroundColor = .white
        profileStack.config.stack.distribution = .equalCentering

        view.addSubview(topView)
        view.addSubview(profileStack)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        
    }

    override func viewDidLoad() {
		super.viewDidLoad()

        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.black.cgColor

        userName.font = .boldSystemFont(ofSize: 30)
        userName.adjustsFontSizeToFitWidth = true
        userName.minimumScaleFactor = 0.3

        userStatus.textColor = .lightGray
        userStatus.font = .boldSystemFont(ofSize: 18)

        userRating.font = .italicSystemFont(ofSize: 24)

        let editImage = UIImage(systemName: "square.and.pencil")


        editButton.setImage(UIImage(cgImage: (editImage?.cgImage)!, scale: 2, orientation: UIImage.Orientation.up), for: .normal) // scale may vary
        editButton.addTarget(self, action: #selector(tappedEdit), for: .touchUpInside)


        profileStack.config.stack.distribution = .fillProportionally
        profileStack.config.stack.spacing = 3
        profileStack.setCustomSpacing(12, after: createButton)

        createButton.backgroundColor = Styles.Color.tinyGray
        let createButtonAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
                                      NSAttributedString.Key.foregroundColor : UIColor.black]
        createButton.setAttributedTitle(NSAttributedString(string: "Создать турнир", attributes: createButtonAttributes), for: .normal)
        createButton.layer.cornerRadius = 30
        createButton.addTarget(self, action: #selector(tappedCreate), for: .touchUpInside)

        myEventsButton.addTarget(self, action: #selector(tappedMyEvents), for: .touchUpInside)

        statisticsButton.addTarget(self, action: #selector(tappedStatistics), for: .touchUpInside)

        fideButton.addTarget(self, action: #selector(tappedFIDE), for: .touchUpInside)

        frcButton.addTarget(self, action: #selector(tappedFRC), for: .touchUpInside)
        
        logout.addTarget(self, action: #selector(tappedLogout), for: .touchUpInside)

        setupConstraints()
	}

    func setupConstraints() {
        NSLayoutConstraint.activate([

            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.bottomAnchor.constraint(equalTo: userStatus.bottomAnchor),

            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.heightAnchor.constraint(equalToConstant: 64),
            imageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),

            userName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            userName.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),

            userStatus.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
            userStatus.leadingAnchor.constraint(equalTo: userName.leadingAnchor),

            editButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            editButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),


            userRating.topAnchor.constraint(equalTo: userName.topAnchor),
            userRating.trailingAnchor.constraint(equalTo: editButton.trailingAnchor),


            createButton.heightAnchor.constraint(equalToConstant: 80),
            myEventsButton.heightAnchor.constraint(equalToConstant: 60),
            statisticsButton.heightAnchor.constraint(equalToConstant: 60),
            fideButton.heightAnchor.constraint(equalToConstant: 60),
            frcButton.heightAnchor.constraint(equalToConstant: 60),

            profileStack.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16),
            profileStack.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            profileStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profileStack.widthAnchor.constraint(equalTo: topView.widthAnchor)
        ])
    }

    @objc
    func tappedEdit() {
        output.editProfile()
    }

    @objc
    func tappedCreate() {
        output.createEvent()
    }

    @objc
    func tappedMyEvents() {
        output.showMyEvents()
    }

    @objc
    func tappedStatistics() {
        output.showStatistics()
    }

    @objc
    func tappedFIDE() {
        output.showFIDE()
    }

    @objc
    func tappedFRC() {
        output.showFRC()
    }
    @objc
    func tappedLogout() {
        output.signOut()
    }
}

extension UserProfileViewController: UserProfileViewInput {
    func updateUser(user: User) {
        userName.text = user.player.lastName + " " + user.player.firstName
        userStatus.text = user.isOrganizer ? "Организатор" : "Игрок"
        userRating.text = String(user.player.classicFideRating!)
    }

}
