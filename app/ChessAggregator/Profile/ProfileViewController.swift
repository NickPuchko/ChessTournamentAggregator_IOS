import Foundation
import UIKit
import FirebaseDatabase

class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    
    var ref: DatabaseReference
    var phone: String
    var testUser: User
    var imageView: UIImageView
    var userImage = UIImage(imageLiteralResourceName: "vaultBoy")
    let userName = UILabel()
    let userRating = UILabel()
    let editButton = UIButton(type: .system)
    let topView = UIView()
    let createButton = UIButton(type: .custom)
    let myEventsLabel = UILabel()
    let divider = UIView()
    private lazy var profileStack = ScrollableStackView(config: .defaultVertical)

    init(ref: DatabaseReference, phone: String) {
        self.ref = ref
        self.phone = phone
        self.imageView = UIImageView(image: userImage)
        self.testUser = User(player: Player(fullName: "John Doe", birthdate: Calendar.current.date(from: DateComponents(year: 1967, month: 2, day: 25))!, rating: 2100), phone: phone, isAdmin: true)
        super.init(nibName: nil, bundle: nil)
    }


    required init?(coder: NSCoder) {
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
        
        topView.backgroundColor = .white
        topView.addSubview(imageView)
        topView.addSubview(userName)
        topView.addSubview(userRating)
        topView.addSubview(editButton)
        
        divider.backgroundColor = .white
        
        myEventsLabel.text = "Мои турниры"
        myEventsLabel.textColor = .white
        profileStack.addArrangedSubview(createButton)
        profileStack.addArrangedSubview(divider)
        profileStack.addArrangedSubview(myEventsLabel)
        profileStack.backgroundColor = .black
        
        view.addSubview(topView)
        view.addSubview(profileStack)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        
        userName.text = testUser.player.fullName
        userName.font = .boldSystemFont(ofSize: 24)
        
        userRating.text = testUser.player.rating.description
        userRating.font = .italicSystemFont(ofSize: 24)
        
        editButton.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        editButton.addTarget(self, action: #selector(tappedEdit), for: .touchUpInside)
        
                
        createButton.setTitle("Создать турнир", for: .normal)
        createButton.addTarget(self, action: #selector(tappedCreate), for: .touchUpInside)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.bottomAnchor.constraint(equalTo: userName.bottomAnchor, constant: 16),
            
            divider.widthAnchor.constraint(equalTo: view.widthAnchor),
            divider.heightAnchor.constraint(equalToConstant: 2),

            myEventsLabel.centerXAnchor.constraint(equalTo: profileStack.centerXAnchor),
            myEventsLabel.widthAnchor.constraint(equalToConstant: 120),
            myEventsLabel.heightAnchor.constraint(equalToConstant: 24),
            
            
            imageView.widthAnchor.constraint(equalToConstant: 64),
            imageView.heightAnchor.constraint(equalToConstant: 64),
            imageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            
            userName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            userName.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16),
            
            editButton.topAnchor.constraint(equalTo: imageView.topAnchor),
            editButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16),
            
            userRating.topAnchor.constraint(equalTo: userName.topAnchor),
            userRating.trailingAnchor.constraint(equalTo: editButton.trailingAnchor),
            
            createButton.heightAnchor.constraint(equalToConstant: 60),
            
            
            profileStack.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 16),
            profileStack.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            profileStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            profileStack.widthAnchor.constraint(equalTo: topView.widthAnchor)
        ])
    }
    
    @objc
    func tappedEdit() {
        print("edit!")
    }
    
    @objc
    func tappedCreate() {
        print("Create!")
    }
}
