//
//  UserPreviewViewController.swift
//  ChessAggregator
//
//  Created by Максим Сурков on 03.03.2021.
//  
//

import UIKit

final class UserPreviewViewController: UIViewController {
    
    
    private let ratingLabel = UILabel()
    private let birthDateLabel = UILabel()
    private let scoresLabel = UILabel()
    private let startNumberLabel = UILabel()
    
	private let output: UserPreviewViewOutput
    private let scrollView = UIScrollView()
    private let contentView =  AutoLayoutView()
    private let generalStack = UIStackView()
    private let shortRatingType = UILabel()
    private var onTapRatingStack = UIGestureRecognizer()
//    private let shortStack = UIStackView()
//    private let shortRatingStack = UIStackView()
//    private let shortRatingLabel = UILabel()
    private let startList = UITableView()
    
//    private let shortRating: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18.0)
//        label.text = "0"
//        return label
//    }()
//private let arrowDown = UIButton(type: .custom)
//    private let fideRatingSegment: RatingSegment = {
//        let segment = RatingSegment(ratingType: "FIDE")
//        segment.updateRatings(classic: "0", rapid: "0", blitz: "0")
//        return segment
//    }()
//    private let frcRatingSegment: RatingSegment = {
//        let segment = RatingSegment(ratingType: "ФШР")
//        segment.updateRatings(classic: "0", rapid: "0", blitz: "0")
//        return segment
//    }()
//    private let profileStack = UIStackView()
    private let spacingView: UIView = {
        let space = UIView()
        space.isHidden = true
        return space
    }()
    private let fideFrcStack = UIStackView()
    private let lineFideFrc = UIView()

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    private var imageDiameter: CGFloat {
        screenWidth/4
    }

    private var imageCornerRadius: CGFloat {
        imageDiameter/2
    }
    private let backgroundColor: UIColor = .white
    private var isStatStackFullMode = false
    
    let fideButton = UIButton(type: .custom)
    let frcButton = UIButton(type: .custom)
    
    let topView = UIView()
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
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18)
        label.text = "Игрок"
        return label
    }()
    
    
    init(output: UserPreviewViewOutput) {
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
        if let viewModel = output.userPreviewModel {
            updateUser(user: viewModel)
        }

        imageView.layer.cornerRadius = imageCornerRadius
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.1
        imageView.layer.borderColor = UIColor.black.cgColor
        
        
        fideButton.addTarget(self, action: #selector(tappedFIDE), for: .touchUpInside)

        frcButton.addTarget(self, action: #selector(tappedFRC), for: .touchUpInside)
	}
    func setup() {

        view.addSubview(contentView)
        contentView.addSubview(topView)
        view.addSubview(frcButton)
        view.addSubview(fideButton)
        view.addSubview(startList)
        
        topView.backgroundColor = backgroundColor
        topView.addSubview(imageView)
        topView.addSubview(userName)
        topView.addSubview(userStatus)
        topView.addSubview(ratingLabel)
        topView.addSubview(birthDateLabel)
        topView.addSubview(scoresLabel)
        topView.addSubview(startNumberLabel)
        self.startList.rowHeight = UITableView.automaticDimension
        self.startList.estimatedRowHeight = 50.0
//        topView.addSubview(generalStack)
//        topView.addSubview(arrowDown)
        
//        generalStack.axis = .vertical
//        generalStack.distribution = .fill
//        generalStack.alignment = .leading
//        generalStack.addArrangedSubview(shortStack)
//        generalStack.addArrangedSubview(fideRatingSegment)
//        generalStack.addArrangedSubview(frcRatingSegment)
//        fideRatingSegment.isHidden = true
//        fideRatingSegment.alpha = 0
//        frcRatingSegment.isHidden = true
//        frcRatingSegment.alpha = 0

//        shortStack.axis = .horizontal
//        shortStack.distribution = .equalSpacing
//        shortStack.alignment = .fill
//        shortStack.spacing = 15.0
//        shortStack.addArrangedSubview(shortRatingType)
//        shortStack.addArrangedSubview(shortRatingStack)

//        shortRatingStack.axis = .horizontal
//        shortRatingStack.distribution = .fill
//        shortRatingStack.alignment = .fill
//        shortRatingStack.addArrangedSubview(shortRatingLabel)
//        shortRatingStack.addArrangedSubview(shortRating)
//
//        shortRatingType.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18.0)
//        shortRatingType.text = "FIDE"
//        shortRatingLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18.0)
//        shortRatingLabel.text = "Классика: "
//
//        arrowDown.tintColor = .black
//        arrowDown.setImage(UIImage(systemName: "chevron.down"), for: .normal)

//        profileStack.axis = .vertical
//        profileStack.distribution = .fillProportionally
//        profileStack.alignment = .center
//        profileStack.addArrangedSubview(spacingView)
//        profileStack.backgroundColor = .red

        //let cgPath = UIBezierPath(roundedRect: <#T##CGRect#>, byRoundingCorners: <#T##UIRectCorner#>, cornerRadii: <#T##CGSize#>)
        let fideBackground = ConfigPreviewButton(image: UIImage(imageLiteralResourceName: "fide"))
        fideButton.addSubview(fideBackground)
        fideButton.backgroundColor = .systemGray6
        fideButton.layer.cornerRadius = 16
        //fideButton.addShadow()
        let frcBackground = ConfigPreviewButton(image: UIImage(imageLiteralResourceName: "frc"))
        frcButton.addSubview(frcBackground)
        //frcButton.addShadow()
        frcButton.backgroundColor = .systemGray6
        frcButton.layer.cornerRadius = 16

//        lineFideFrc.backgroundColor = Styles.Color.lightGray
//
//        fideFrcStack.axis = .horizontal
//        fideFrcStack.distribution = .fill
//        fideFrcStack.alignment = .center
//
//        fideFrcStack.backgroundColor = .white
//        fideFrcStack.layer.cornerRadius = 30
//        fideFrcStack.layer.borderColor = UIColor.gray.cgColor
//        fideFrcStack.layer.shadowOffset = .zero
//        fideFrcStack.layer.shadowColor = fideFrcStack.layer.borderColor
//        fideFrcStack.layer.shadowOpacity = 0.7
//        fideFrcStack.layer.shadowRadius = 8

        //fideFrcStack.addArrangedSubview(fideButton)
        //fideFrcStack.addArrangedSubview(lineFideFrc)
        //fideFrcStack.addArrangedSubview(frcButton)
        
        startList.delegate = self
        startList.dataSource = self
        startList.register(PreviewCustomCell.self, forCellReuseIdentifier: "preview")
        startList.separatorColor = .clear
        //startList.isScrollEnabled = false
        //startList.rowHeight = 50
        
        ratingLabel.text = "Рейтинг (FIDE - классика): 1488"
        birthDateLabel.text = "Дата рождения: 19.03.2200"
        scoresLabel.text = "Очки: 1222"
        startNumberLabel.text = "Стартовый номер: 23/108"
    }
    func setupConstraints() { [
        //fideRatingSegment,
        //scrollView,
        contentView,
        topView,
        //generalStack,
        //shortRatingType,
        //shortRatingStack,
        //arrowDown,
        ratingLabel,
        birthDateLabel,
        scoresLabel,
        startNumberLabel,
        imageView,
        //fideFrcStack,
        userName,
        fideButton,
        lineFideFrc,
        frcButton,
        userStatus,
        startList
    ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            //topView.bottomAnchor.constraint(equalTo: generalStack.bottomAnchor),

            imageView.widthAnchor.constraint(equalToConstant: imageDiameter),
            imageView.heightAnchor.constraint(equalToConstant: imageDiameter),
            imageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),

            userName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            userName.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),

            userStatus.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
            userStatus.centerXAnchor.constraint(equalTo: userName.centerXAnchor),
            
            ratingLabel.topAnchor.constraint(equalTo: userStatus.bottomAnchor, constant: 6),
            ratingLabel.centerXAnchor.constraint(equalTo: userStatus.centerXAnchor),
            
            birthDateLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 6),
            birthDateLabel.leadingAnchor.constraint(equalTo: ratingLabel.leadingAnchor),
            //birthDateLabel.centerXAnchor.constraint(equalTo: ratingLabel.centerXAnchor),
            
            scoresLabel.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: 6),
            scoresLabel.leadingAnchor.constraint(equalTo: birthDateLabel.leadingAnchor),
            //scoresLabel.centerXAnchor.constraint(equalTo: birthDateLabel.centerXAnchor),
            
            startNumberLabel.topAnchor.constraint(equalTo: scoresLabel.bottomAnchor, constant: 6),
            startNumberLabel.leadingAnchor.constraint(equalTo: scoresLabel.leadingAnchor),
            
            

//            generalStack.topAnchor.constraint(equalTo: userStatus.bottomAnchor, constant: 10.0),
//            generalStack.trailingAnchor.constraint(equalTo: arrowDown.leadingAnchor, constant: -20.0),

//            arrowDown.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 25.0),
//            arrowDown.topAnchor.constraint(equalTo: userStatus.bottomAnchor, constant: 10.0),
//            arrowDown.widthAnchor.constraint(equalToConstant: 18.0),
//            arrowDown.heightAnchor.constraint(equalToConstant: 23.0),

            fideButton.topAnchor.constraint(equalTo: startNumberLabel.bottomAnchor, constant: 10),
            fideButton.trailingAnchor.constraint(equalTo: ratingLabel.centerXAnchor, constant: -10),
            fideButton.heightAnchor.constraint(equalToConstant: 80),
            fideButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),

            
            frcButton.topAnchor.constraint(equalTo: fideButton.topAnchor),
            frcButton.leadingAnchor.constraint(equalTo: ratingLabel.centerXAnchor, constant: 10),
            frcButton.heightAnchor.constraint(equalTo: fideButton.heightAnchor),
            frcButton.widthAnchor.constraint(equalTo: fideButton.widthAnchor),
//
//            lineFideFrc.heightAnchor.constraint(equalToConstant: 2.0),
//            lineFideFrc.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 30),
//            lineFideFrc.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
//
//            spacingView.heightAnchor.constraint(equalToConstant: 20.0),

//            profileStack.topAnchor.constraint(equalTo: generalStack.bottomAnchor, constant: 20.0),
//            profileStack.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: -5),
//            profileStack.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 5),
            
//            fideFrcStack.topAnchor.constraint(equalTo: startNumberLabel.bottomAnchor, constant: 20.0),
//            fideFrcStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
//            fideFrcStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15),
            
            startList.topAnchor.constraint(equalTo: fideButton.bottomAnchor, constant: 10),
            startList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            startList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            startList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
//    @objc func onTapStatButton() {
//        isStatStackFullMode = !isStatStackFullMode
//        UIView.animate(withDuration: 0.5) { () -> Void in
//            if(self.isStatStackFullMode) {
//                self.arrowDown.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//            } else {
//                self.arrowDown.transform = CGAffineTransform(rotationAngle: -2*CGFloat.pi)
//            }
//        }
//        if isStatStackFullMode {
//            UIView.animate(withDuration: 0.5, animations: {
//                self.shortStack.alpha = 0
//            }, completion: { _ in
//                self.shortStack.isHidden = true
//                UIView.animate(withDuration: 0.5) {
//                    self.frcRatingSegment.alpha = 1
//                    self.fideRatingSegment.alpha = 1
//                    self.frcRatingSegment.isHidden = false
//                    self.fideRatingSegment.isHidden = false
//                }
//            })
//        } else {
//            UIView.animate(withDuration: 0.5, animations: {
//                self.frcRatingSegment.alpha = 0
//                self.fideRatingSegment.alpha = 0
//            }, completion: { _ in
//                self.shortStack.isHidden = false
//                UIView.animate(withDuration: 0.5) {
//                    self.frcRatingSegment.isHidden = true
//                    self.fideRatingSegment.isHidden = true
//                    self.shortStack.alpha = 1
//                }
//            })
//        }
//        generalStack.layoutIfNeeded()
//    }
//
    @objc
    func tappedFIDE() {
        output.showFIDE()
    }

    @objc
    func tappedFRC() {
        output.showFRC()
    }
}

extension UserPreviewViewController: UserPreviewViewInput {
    func updateUser(user: UserPreviewModel) {
//        userName.text = user.userName
//        userStatus.text = user.userStatus
//        shortRating.text = user.classicFideRating
//        fideRatingSegment.updateRatings(
//                classic: user.classicFideRating,
//                rapid: user.rapidFideRating,
//                blitz: user.blitzFideRating)
//        frcRatingSegment.updateRatings(
//                classic: user.classicFrcRating,
//                rapid: user.rapidFrcRating,
//                blitz: user.blitzFrcRating)
//        spacingView.isHidden = !user.isOrganizer
    }
}

extension UserPreviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "preview", for:  indexPath) as!
        PreviewCustomCell
        cell.gameNumberLabel.text = String(indexPath.row + 1)
        return cell
    }
}

