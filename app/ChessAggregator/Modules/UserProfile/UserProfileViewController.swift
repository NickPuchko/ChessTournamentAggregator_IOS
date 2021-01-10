

import UIKit

final class UserProfileViewController: UIViewController {
	private let output: UserProfileViewOutput

    private let scrollView = UIScrollView()
    private let contentView =  AutoLayoutView()
    let topView = UIView()

    let editButton = UIButton(type: .system)
    var imageView: UIImageView
    var userImage = UIImage(imageLiteralResourceName: "vaultBoy")

    let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.text = "Имя пользователя"
        return label
    }()

    let userStatus: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Игрок"
        return label
    }()

    private let generalStack = UIStackView()
    private let shortRatingType = UILabel()
    private var onTapRatingStack = UIGestureRecognizer()
    private let shortStack = UIStackView()
    private let shortRatingStack = UIStackView()
    private let shortRatingLabel = UILabel()
    private let shortRating: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18.0)
        label.text = "0"
        return label
    }()
    private let arrowDown = UIButton(type: .custom)
//    private let fullRatingStack = UIStackView()
    private let fideRatingSegment: RatingSegment = {
        let segment = RatingSegment(ratingType: "FIDE")
        segment.updateRatings(classic: "0", rapid: "0", blitz: "0")
        return segment
    }()
    private let frcRatingSegment: RatingSegment = {
        let segment = RatingSegment(ratingType: "ФШР")
        segment.updateRatings(classic: "0", rapid: "0", blitz: "0")
        return segment
    }()

    private let profileStack = UIStackView()
    private let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        return button
    }()
    private let spacingView: UIView = {
        let space = UIView()
        space.isHidden = true
        return space
    }()
    let statisticsButton = UIButton(type: .custom)

    private let fideFrcStack = UIStackView()
    let fideButton = UIButton(type: .custom)
    private let lineFideFrc = UIView()
    let frcButton = UIButton(type: .custom)

    private let exitButton = UIButton(type: .system)

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    private var imageDiameter: CGFloat {
        screenWidth/3
    }
    private var imageCornerRadius: CGFloat {
        imageDiameter/2
    }
    private let backgroundColor: UIColor = .white
    private var isStatStackFullMode = false

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
        view.backgroundColor = backgroundColor
        setup()
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.layer.cornerRadius = imageCornerRadius
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.black.cgColor


        let editImage = UIImage(systemName: "square.and.pencil")


        editButton.setImage(UIImage(cgImage: (editImage?.cgImage)!, scale: 1.3, orientation: UIImage.Orientation.up), for: .normal) // scale may vary
        editButton.addTarget(self, action: #selector(tappedEdit), for: .touchUpInside)

        createButton.backgroundColor = Styles.Color.buttonBlue
        let createButtonAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
                                      NSAttributedString.Key.foregroundColor : UIColor.white]
        createButton.setAttributedTitle(NSAttributedString(string: "Создать турнир", attributes: createButtonAttributes), for: .normal)
        createButton.layer.shadowColor = Styles.Color.buttonBlue.cgColor
        createButton.layer.shadowOpacity = 1.0
        createButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        createButton.layer.shadowRadius = 5.5
        createButton.layer.cornerRadius = 15

        createButton.addTarget(self, action: #selector(tappedCreate), for: .touchUpInside)

        statisticsButton.addTarget(self, action: #selector(tappedStatistics), for: .touchUpInside)

        fideButton.addTarget(self, action: #selector(tappedFIDE), for: .touchUpInside)

        frcButton.addTarget(self, action: #selector(tappedFRC), for: .touchUpInside)

        arrowDown.addTarget(self, action: #selector(onTapStatButton), for: .touchUpInside)

        exitButton.addTarget(self, action: #selector(tappedLogout), for: .touchUpInside)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    func setup() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(topView)
        contentView.addSubview(profileStack)
        contentView.addSubview(fideFrcStack)
        contentView.addSubview(exitButton)

        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false

        topView.backgroundColor = backgroundColor
        topView.addSubview(imageView)
        topView.addSubview(userName)
        topView.addSubview(userStatus)
        topView.addSubview(generalStack)
//        topView.addSubview(fullRatingStack)
//        topView.addSubview(shortRatingType)
//        topView.addSubview(shortRatingStack)
        topView.addSubview(arrowDown)
        topView.addSubview(editButton)

        //TODO: выяснить что здесь происходит, почему так работает анимация, пока не удалять.
        generalStack.axis = .vertical
        generalStack.distribution = .fill
        generalStack.alignment = .fill
        generalStack.addArrangedSubview(shortStack)
        generalStack.addArrangedSubview(fideRatingSegment)
        generalStack.addArrangedSubview(frcRatingSegment)
        generalStack.removeArrangedSubview(fideRatingSegment)
        generalStack.removeArrangedSubview(frcRatingSegment)
        fideRatingSegment.isHidden = true
        frcRatingSegment.isHidden = true


        shortStack.axis = .horizontal
        shortStack.distribution = .equalSpacing
        shortStack.alignment = .fill
        shortStack.spacing = 15.0
        shortStack.addArrangedSubview(shortRatingType)
        shortStack.addArrangedSubview(shortRatingStack)

        shortRatingStack.axis = .horizontal
        shortRatingStack.distribution = .fill
        shortRatingStack.alignment = .fill
        shortRatingStack.addArrangedSubview(shortRatingLabel)
        shortRatingStack.addArrangedSubview(shortRating)

        shortRatingType.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18.0)
        shortRatingType.text = "FIDE"
        shortRatingLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18.0)
        shortRatingLabel.text = "Классика: "

        arrowDown.tintColor = .black
        arrowDown.setImage(UIImage(systemName: "chevron.down"), for: .normal)

//        fullRatingStack.isHidden = true
//        fideRatingSegment.ratingSegmentSubviews(isHidden: true)
//        frcRatingSegment.isHidden = true
//        fullRatingStack.axis = .vertical
//        fullRatingStack.distribution = .fillProportionally
//        fullRatingStack.alignment = .trailing
//        fullRatingStack.addArrangedSubview(fideRatingSegment)
//        fullRatingStack.addArrangedSubview(frcRatingSegment)

        let statisticsBackground = StatisticRow(name: "Статистика")
        statisticsButton.addSubview(statisticsBackground)

        profileStack.axis = .vertical
        profileStack.distribution = .fillProportionally
        profileStack.alignment = .center
        profileStack.addArrangedSubview(createButton)
        profileStack.addArrangedSubview(spacingView)
        profileStack.addArrangedSubview(statisticsButton)

        let fideBackground = ProfileRaw(name: "Профиль FIDE")
        fideButton.addSubview(fideBackground)

        let frcBackground = ProfileRaw(name: "Профиль ФШР")
        frcButton.addSubview(frcBackground)

        lineFideFrc.backgroundColor = Styles.Color.lightGray

        fideFrcStack.axis = .vertical
        fideFrcStack.distribution = .fill
        fideFrcStack.alignment = .fill

        fideFrcStack.backgroundColor = .white
        fideFrcStack.layer.cornerRadius = 18.0
        fideFrcStack.clipsToBounds = true
        fideFrcStack.addArrangedSubview(fideButton)
        fideFrcStack.addArrangedSubview(lineFideFrc)
        fideFrcStack.addArrangedSubview(frcButton)

        exitButton.setTitle("Выйти", for: .normal)
        exitButton.setTitleColor(Styles.Color.redExit, for: .normal)
        exitButton.titleLabel!.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 22.0)
    }

    func setupConstraints() { [
        fideRatingSegment,
        scrollView,
        contentView,
        topView,
        generalStack,
        shortRatingType,
        shortRatingStack,
        arrowDown,
//        fullRatingStack,
        imageView,
        fideFrcStack,
        userName,
        editButton,
        createButton,
        statisticsButton,
        fideButton,
        lineFideFrc,
        frcButton,
        userStatus
    ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        let margins = view.safeAreaLayoutGuide
        scrollView.pins()
        contentView.pins()
        topView.top()
        exitButton.bottom(-20)
        statisticsButton.horizontal()
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            topView.bottomAnchor.constraint(equalTo: fullRatingStack.bottomAnchor),
            topView.bottomAnchor.constraint(equalTo: generalStack.bottomAnchor),

            editButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor),

            imageView.widthAnchor.constraint(equalToConstant: imageDiameter),
            imageView.heightAnchor.constraint(equalToConstant: imageDiameter),
            imageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),

            userName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            userName.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),

            userStatus.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
            userStatus.centerXAnchor.constraint(equalTo: userName.centerXAnchor),

            generalStack.topAnchor.constraint(equalTo: userStatus.bottomAnchor, constant: 10.0),
            generalStack.leadingAnchor.constraint(equalTo: userName.leadingAnchor, constant: -40.0),


//            shortRatingType.leadingAnchor.constraint(equalTo: userName.leadingAnchor, constant: -30.0),
//            shortRatingType.topAnchor.constraint(equalTo: userStatus.bottomAnchor, constant: 10.0),
//
//            shortRatingStack.leadingAnchor.constraint(equalTo: shortRatingType.trailingAnchor, constant: 15.0),
//            shortRatingStack.topAnchor.constraint(equalTo: userStatus.bottomAnchor, constant: 10.0),

//            arrowDown.leadingAnchor.constraint(equalTo: shortRatingStack.trailingAnchor, constant: 16.0),
//            arrowDown.centerYAnchor.constraint(equalTo: shortRatingStack.centerYAnchor),
            arrowDown.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 25.0),
            arrowDown.topAnchor.constraint(equalTo: userStatus.bottomAnchor, constant: 10.0),
            arrowDown.widthAnchor.constraint(equalToConstant: 18.0),
            arrowDown.heightAnchor.constraint(equalToConstant: 23.0),

//            fullRatingStack.topAnchor.constraint(equalTo: userStatus.bottomAnchor, constant: 10.0),
//            fullRatingStack.leadingAnchor.constraint(equalTo: shortRatingType.leadingAnchor),

            createButton.heightAnchor.constraint(equalToConstant: 80.0),
            createButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 20.0),
            createButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -20.0),

            statisticsButton.heightAnchor.constraint(equalToConstant: 90.0),
            fideButton.heightAnchor.constraint(equalToConstant: 90),
            frcButton.heightAnchor.constraint(equalToConstant: 90),
            lineFideFrc.heightAnchor.constraint(equalToConstant: 2.0),
            spacingView.heightAnchor.constraint(equalToConstant: 20.0),

            profileStack.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20.0),
            profileStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: -5),
            profileStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 5),

            fideFrcStack.topAnchor.constraint(equalTo: statisticsButton.bottomAnchor, constant: 20.0),
            fideFrcStack.leadingAnchor.constraint(equalTo: profileStack.leadingAnchor),
            fideFrcStack.trailingAnchor.constraint(equalTo: profileStack.trailingAnchor),
            fideFrcStack.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -25),

            exitButton.heightAnchor.constraint(equalTo: exitButton.titleLabel!.heightAnchor),
            exitButton.widthAnchor.constraint(equalTo: exitButton.titleLabel!.widthAnchor),
            exitButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor)
        ])
    }

    @objc func onTapStatButton() {
//        viewSlideInFromTopToBottom(view: fullRatingStack)
        isStatStackFullMode = !isStatStackFullMode
        UIView.animate(withDuration: 0.5) { () -> Void in
            if(self.isStatStackFullMode) {
                self.arrowDown.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            } else {
                self.arrowDown.transform = CGAffineTransform(rotationAngle: -2*CGFloat.pi)
            }

        }

        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let strongSelf = self else { return }
            if(strongSelf.isStatStackFullMode) {
                strongSelf.generalStack.removeArrangedSubview(strongSelf.shortStack)
                strongSelf.generalStack.addArrangedSubview(strongSelf.fideRatingSegment)
                strongSelf.generalStack.addArrangedSubview(strongSelf.frcRatingSegment)
                strongSelf.shortStack.isHidden = true
                strongSelf.frcRatingSegment.isHidden = false
                strongSelf.fideRatingSegment.isHidden = false
            } else {
                strongSelf.generalStack.removeArrangedSubview(strongSelf.frcRatingSegment)
                strongSelf.generalStack.removeArrangedSubview(strongSelf.fideRatingSegment)
                strongSelf.generalStack.addArrangedSubview(strongSelf.shortStack)
                strongSelf.frcRatingSegment.isHidden = true
                strongSelf.fideRatingSegment.isHidden = true
                strongSelf.shortStack.isHidden = false
            }
            strongSelf.generalStack.layoutIfNeeded()
        }
//        shortRatingStack.isHidden = !isStatStackFullMode
//        shortRatingType.isHidden = !isStatStackFullMode
//        fullRatingStack.isHidden = isStatStackFullMode
//        frcRatingSegment.isHidden = isStatStackFullMode
//        fideRatingSegment.ratingSegmentSubviews(isHidden: isStatStackFullMode)
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

    func viewSlideInFromTopToBottom(view: UIView) -> Void {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .reveal
        transition.subtype = .fromBottom
        view.layer.add(transition, forKey: kCATransition)
    }
}

extension UserProfileViewController: UserProfileViewInput {
    func updateUser(user: UserViewModel) {
        userName.text = user.userName
        userStatus.text = user.userStatus
        shortRating.text = user.classicFideRating
        fideRatingSegment.updateRatings(
                classic: user.classicFideRating,
                rapid: user.rapidFideRating,
                blitz: user.blitzFideRating)
        frcRatingSegment.updateRatings(
                classic: user.classicFrcRating,
                rapid: user.rapidFrcRating,
                blitz: user.blitzFrcRating)
        createButton.isHidden = false
        spacingView.isHidden = false
    }

}
