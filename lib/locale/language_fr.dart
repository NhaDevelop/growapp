import '../configs.dart';
import 'languages.dart';

class LanguageFr extends BaseLanguage {
  @override
  String get tokenExpired => 'Jeton expiré';

  @override
  String get badRequest => '400: Mauvaise demande';

  @override
  String get forbidden => '403: interdit';

  @override
  String get pageNotFound => '404 Page non trouvée';

  @override
  String get tooManyRequests => '429: trop de demandes';

  @override
  String get internalServerError => '500: Erreur du serveur interne';

  @override
  String get badGateway => '502 Mauvaise passerelle';

  @override
  String get serviceUnavailable => '503 Service Indisponible';

  @override
  String get gatewayTimeout => '504 portail expiré';

  @override
  String get hey => 'Hé';

  @override
  String get helloUser => 'Bonjour utilisateur!';

  @override
  String get createYourAccountFor => 'Créez votre compte pour une meilleure expérience';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom de famille';

  @override
  String get email => 'E-mail';

  @override
  String get thisFieldIsRequired => 'Ce champ est obligatoire';

  @override
  String get contactNumber => 'Numéro de contact';

  @override
  String get password => 'Mot de passe';

  @override
  String get signUp => "S'inscrire";

  @override
  String get alreadyHaveAnAccount => 'Vous avez déjà un compte?';

  @override
  String get signIn => "S'identifier";

  @override
  String get welcomeBack => 'Content de te revoir!';

  @override
  String get youHaveBeenMissed => 'Tu as manqué depuis longtemps';

  @override
  String get rememberMe => 'Souviens-toi de moi';

  @override
  String get forgotPassword => 'Mot de passe oublié?';

  @override
  String get registerNow => "S'inscrire maintenant";

  @override
  String get or => 'OU';

  @override
  String get pleaseEnterValidOtp => 'Veuillez saisir un OTP valide';

  @override
  String get otpVerification => 'Vérification OTP';

  @override
  String get checkYourMailAnd => 'Vérifiez votre courrier et entrez le code que vous obtenez';

  @override
  String get didNotGetTheOtp => "Vous n'avez pas eu l'OTP?";

  @override
  String get resendOtp => 'Repenser otp';

  @override
  String get verify => 'Vérifier';

  @override
  String get enterYourEmailAddress => 'Entrez votre adresse email';

  @override
  String get aResetPasswordLink => "Un lien de mot de passe de réinitialisation sera envoyé à l'adresse e-mail saisie ci-dessus";

  @override
  String get resetPassword => 'réinitialiser le mot de passe';

  @override
  String get areYouSureWantToPerformThisAction => 'Êtes-vous sûr de vouloir effectuer cette action?';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get gallery => 'Galerie';

  @override
  String get camera => 'Caméra';

  @override
  String get editProfile => 'Editer le profil';

  @override
  String get update => 'Mise à jour';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get newPasswordsMustBeDifferent => 'Les nouveaux mots de passe doivent être différents des précédents';

  @override
  String get oldPassword => 'ancien mot de passe';

  @override
  String get newPassword => 'nouveau mot de passe';

  @override
  String get thePasswordDoesNotMatch => 'Le mot de passe ne correspond pas';

  @override
  String get reEnterPassword => 'Entrez à nouveau le mot de passe';

  @override
  String get confirm => 'Confirmer';

  @override
  String get pleaseLoginAgain => 'Veuillez vous connecter à nouveau';

  @override
  String get loginSuccessfully => 'Connectez-vous avec succès';

  @override
  String get noUserFound => 'Aucun utilisateur trouvé';

  @override
  String get otpInvalidMessage => "Le code entré n'est pas valide, veuillez réessayer";

  @override
  String get pleaseContactWithAdmin => "Veuillez contacter avec l'administrateur";

  @override
  String get confirmOtp => 'Confirmer OTP';

  @override
  String get verified => 'Vérifié';

  @override
  String get signInFailed => 'La connexion a échoué';

  @override
  String get appleSigInIsNotAvailable => "Apple Signin n'est pas disponible pour votre appareil";

  @override
  String get emailAddressIsRequiredUpdateAppleAccount => 'Adresse e-mail est nécessaire. Veuillez mettre à jour les e-mails dans votre compte Apple';

  @override
  String get yourPasswordReset => 'Votre réinitialisation de mot de passe';

  @override
  String get yourAccountIsReady => "Votre compte est prêt à l'emploi. Profitez de notre spécialiste et de nos services";

  @override
  String get yourPassWorResetSuccessfully => 'Votre mot de passe réinitialise avec succès';

  @override
  String get done => 'Fait';

  @override
  String get specialist => 'Spécialiste';

  @override
  String get date => 'Date';

  @override
  String get time => 'Temps';

  @override
  String get payment => 'Paiement';

  @override
  String get noDetailsFound => 'Aucun détail trouvé';

  @override
  String get reload => 'Recharger';

  @override
  String get locationInformation => 'Information de Lieu';

  @override
  String get name => 'Nom';

  @override
  String get address => 'Adresse';

  @override
  String get quickBookAppointment => 'Rendez-vous de livre rapide';

  @override
  String get service => 'Service';

  @override
  String get total => 'Total';

  @override
  String get bookNow => 'Reserve maintenant';

  @override
  String get pleaseSelectService => 'Veuillez sélectionner le service';

  @override
  String get confirmBooking => 'Confirmer la réservation';

  @override
  String get doYouWantToConfirmBooking => 'Voulez-vous confirmer cette réservation?';

  @override
  String get paymentDetails => 'Détails de paiement';

  @override
  String get subtotal => 'Total';

  @override
  String get tip => 'Conseil';

  @override
  String get discount => 'Rabais';

  @override
  String get yourReview => 'Votre avis';

  @override
  String get deleteReview => "Supprimer l'examen";

  @override
  String get doYouWantToDeleteReview => 'Voulez-vous supprimer cette critique?';

  @override
  String get viewAll => 'Voir tout';

  @override
  String get rate => 'Taux';

  @override
  String get paymentMethod => 'Mode de paiement';

  @override
  String get goToBookings => 'Aller aux réservations';

  @override
  String get yourBookingFor => 'Votre réservation pour';

  @override
  String get bookingSuccessful => 'Réserver réussi!';

  @override
  String get cashAfterService => 'Espèce après le service';

  @override
  String get razorpay => 'Razorpay';

  @override
  String get stripe => 'Bande';

  @override
  String get doWantToBookAppointment => 'Vous voulez prendre ce rendez-vous?';

  @override
  String get noTimeSlots => 'Pas de plages horaires';

  @override
  String get availableSlots => 'Créneaux disponibles';

  @override
  String get next => 'Suivant';

  @override
  String get pleaseSelectTimeSlotFirst => "Veuillez sélectionner d'abord la plage horaire";

  @override
  String get chooseYourExpert => 'Choisissez votre expert';

  @override
  String get pleaseChooseYourExpert => "Veuillez d'abord choisir votre expert";

  @override
  String get services => 'Prestations de service';

  @override
  String get cancelAppointment => 'Annuler rendez-vous';

  @override
  String get doYouWantToCancelBooking => 'Voulez-vous annuler cette réservation?';

  @override
  String get bookingInformation => 'Informations sur la réservation';

  @override
  String get status => 'Statut';

  @override
  String get chooseBranch => 'Choisissez la branche';

  @override
  String get noBranchFound => 'Aucune branche trouvée';

  @override
  String get doYouWantExplore => 'Voulez-vous explorer';

  @override
  String get nearbyBranches => 'Branches voisines';

  @override
  String get about => 'À propos';

  @override
  String get reviews => 'Commentaires';

  @override
  String get staff => 'Personnel';

  @override
  String get noServicesFound => 'Aucun service trouvé';

  @override
  String get noReviewsFound => 'Aucune critique trouvée';

  @override
  String get yourReviewsWillBeAppearedHere => 'Vos avis seront apparus ici';

  @override
  String get call => 'Appel';

  @override
  String get direction => 'Direction';

  @override
  String get noGalleryFound => 'Aucune galerie trouvée';

  @override
  String get workingHours => "Heures d'ouverture";

  @override
  String get ourCategory => 'Notre catégorie';

  @override
  String get noCategoryFound => 'Aucune catégorie trouvée';

  @override
  String get pressBackAgainToExitApp => "Appuyez à nouveau pour quitter l'application";

  @override
  String get home => 'Maison';

  @override
  String get booking => 'Réservation';

  @override
  String get notifications => 'Notifications';

  @override
  String get user => 'Utilisateur';

  @override
  String get profile => 'Profil';

  @override
  String get setting => 'Paramètre';

  @override
  String get appLanguage => "Langage de l'application";

  @override
  String get theme => 'Thème';

  @override
  String get aboutApp => "À propos de l'application";

  @override
  String get rateUs => 'Évaluez nous';

  @override
  String get share => 'Partager';

  @override
  String get help => 'Aider';

  @override
  String get helpCenter => "Centre d'aide";

  @override
  String get privacyPolicy => 'politique de confidentialité';

  @override
  String get tC => 'T&C';

  @override
  String get logout => 'Se déconnecter';

  @override
  String get logoutYourAccount => 'Déconnectez votre compte';

  @override
  String get ohNoYouAreLeaving => 'Oh non, tu pars!';

  @override
  String get doYouWantToLogout => 'Voulez-vous vous connecter?';

  @override
  String get noNotifications => 'Aucune notification';

  @override
  String get weLlNotifyYouOnce => 'Nous vous informerons une fois que nous aurons quelque chose pour vous';

  @override
  String get searchForServices => 'Rechercher des services';

  @override
  String get searchServices => 'Services de recherche';

  @override
  String get searchBooking => 'Réservation de recherche';

  @override
  String get topExperts => 'Top experts';

  @override
  String get theUserHasDeniedSpeechRecognition => "L'utilisateur a nié l'utilisation de la reconnaissance vocale";

  @override
  String get category => 'Catégorie';

  @override
  String get kms => 'Km';

  @override
  String get fromYourLocation => 'De votre emplacement';

  @override
  String get noBookingsFound => 'Aucune réservation trouvée';

  @override
  String get notAMember => 'Pas un membre?';

  @override
  String get noStaffFound => 'Aucun personnel trouvé';

  @override
  String get contactInfo => 'Informations de contact';

  @override
  String get noReviewsYetFor => 'Aucune critique pour le moment';

  @override
  String get language => 'Langue';

  @override
  String get appTheme => "Thème de l'application";

  @override
  String get termsConditions => 'termes et conditions';

  @override
  String get app => 'Appliquer';

  @override
  String get light => 'Lumière';

  @override
  String get dark => 'Sombre';

  @override
  String get systemDefault => 'Défaillance du système';

  @override
  String get chooseTheme => 'Choisir le thème';

  @override
  String get allServices => 'Tous les services';

  @override
  String get searchFor => 'Rechercher';

  @override
  String get subCategories => 'Sous-catégories';

  @override
  String get clear => 'Clair';

  @override
  String get welcomeToThe => 'Bienvenue à la';

  @override
  String get salon => 'Salon';

  @override
  String get weProvideYouBestServiceMessage => 'Nous vous fournissons les meilleurs services et les meilleurs';

  @override
  String get userExperience => 'expérience utilisateur';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get pending => 'En attente';

  @override
  String get confirmed => 'Confirmé';

  @override
  String get cancelled => 'Annulé';

  @override
  String get checkIn => 'Enregistrement';

  @override
  String get checkOut => 'Vérifier';

  @override
  String get completed => 'Complété';

  @override
  String get invalidUrl => 'URL invalide';

  @override
  String get enterYourReviewOptional => 'Entrez votre avis (facultatif)';

  @override
  String get cancel => 'Annuler';

  @override
  String get submit => 'Soumettre';

  @override
  String get ratingIsRequired => 'La notation est requise';

  @override
  String get timeSlotBookedMessage => 'est déjà réservé! Veuillez choisir un autre lieu de temps';

  @override
  String get branchName => 'Nom de la filiale';

  @override
  String get place => 'Lieu';

  @override
  String get basedOn => 'Basé sur';

  @override
  String get review => 'Examen';

  @override
  String get s => 's';

  @override
  String get error => 'Erreur:';

  @override
  String get externalWallet => 'Portefeuille externe:';

  @override
  String get userCancelled => 'Utilisateur annulé';

  @override
  String get userNotFound => 'Utilisateur non trouvé';

  @override
  String get dateIsRequired => 'La date est requise';

  @override
  String get timeIsRequired => 'Le temps est requis';

  @override
  String get findYourNearestSalon => 'Trouvez votre salon le plus proche';

  @override
  String get walkThrough1subTitle => 'Vous pouvez trouver facilement près de votre meilleur coiffeur et salon et profiter de la meilleure expérience de service';

  @override
  String get pickAService => 'Choisir un service';

  @override
  String get walkThrough2subTitle => 'Vous pouvez choisir votre service et choisir votre spécialiste et obtenir une réservation rapide';

  @override
  String get quickBooking => 'Réservation rapide';

  @override
  String get walkThrough3subTitle => 'Vous obtenez les meilleurs services et le meilleur spécialiste de vos services de notre';

  @override
  String get skip => 'Sauter';

  @override
  String get getStarted => 'Commencer';

  @override
  String get delete => 'Supprimer';

  @override
  String get deleteAccount => 'Supprimer le compte';

  @override
  String get signInYourAccount => 'Connectez votre compte';

  @override
  String get deleteAccountConfirmation => 'Votre compte sera supprimé en permanence. Vos données ne seront plus restaurées.';

  @override
  String get dangerZone => 'Zone dangereuse';

  @override
  String get helloGuest => 'Bonjour, invité';

  @override
  String get signInWith => 'Se connecter avec';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Pomme';

  @override
  String get termsConditionsMessage => "J'ai lu l'avertissement et je suis d'accord sur les termes et conditions";

  @override
  String get pleaseAcceptTermsAndConditions => 'Veuillez accepter les termes et conditions';

  @override
  String get description => 'Description';

  @override
  String get serviceNote => 'Note de service';

  @override
  String get priceMayBeUpdated => 'Le prix peut être mis à jour';

  @override
  String get optionalDetails => 'Détails facultatifs';

  @override
  String get reschedule => 'Reprogrammer';

  @override
  String get priceDetails => 'Détails des prix';

  @override
  String get transactionId => 'identifiant de transaction';

  @override
  String get paymentStatus => 'Statut de paiement';

  @override
  String get paid => 'Payé';

  @override
  String get goBack => 'Retourner';

  @override
  String get noStaffAvailableForBranchMessage => 'Aucun personnel disponible pour le service sélectionné!';

  @override
  String get tryToChangeYourService => 'Essayez de changer votre service';

  @override
  String get pay => 'Payer';

  @override
  String get open => 'Ouvrir';

  @override
  String get closed => 'Fermé';

  @override
  String get selectEmployeeFirst => "Sélectionnez d'abord l'employé";

  @override
  String get yourBookingForHairBookingMessage => 'Votre réservation pour la coupe de cheveux a été réservée avec succès';

  @override
  String get back => 'Dos';

  @override
  String get taxIncluded => 'taxe inclu';

  @override
  String get demoUserCannotBeGrantedForThis => "L'utilisateur de démonstration ne peut pas être accordé pour cette action";

  @override
  String get payNow => 'Payez maintenant';

  @override
  String get pleaseTryAgain => 'Veuillez réessayer';

  @override
  String get somethingWentWrong => "Quelque chose s'est mal passé";

  @override
  String get yourInternetIsNotWorking => 'Votre Internet ne fonctionne pas';

  @override
  String get youCannotBookPrevious => 'Vous ne pouvez pas réserver des machines à sous précédentes';

  @override
  String get galleryWillBeAppearedHere => 'La galerie sera apparue ici';

  @override
  String get goToBookingDetail => 'Aller au détail de réservation';

  @override
  String get yourPaymentIsPaidSuccessfullyMessage => 'Votre paiement est payé avec succès avec';

  @override
  String get paymentSuccessful => 'Paiement réussi!';

  @override
  String get edit => 'Modifier';

  @override
  String get bookingTimeSlotChangeMessage => 'Voulez-vous changer le créneau horaire de cette réservation?';

  @override
  String get change => 'Changement';

  @override
  String get profileUpdatedSuccessfully => 'Mise à jour du profil réussie';

  @override
  String get oldPasswordDoesNotMatchMessage => 'Votre ancien mot de passe ne corrige pas!';

  @override
  String get bookingSuccessfullyUpdateMessage => 'La réservation a été mise à jour avec succès';

  @override
  String get newUpdate => 'Nouvelle mise à jour';

  @override
  String get anUpdateToIs => "Une mise à jour de $APP_NAME est disponible. Allez à Play Store et téléchargez la nouvelle version de l'application.";

  @override
  String get closeApp => "Fermer l'application";

  @override
  String get paystack => 'Paystack';

  @override
  String get paypal => 'Pay Pal';

  @override
  String get male => 'Homme';

  @override
  String get female => 'Femme';

  @override
  String get other => 'Autre';

  @override
  String get gender => 'Genre';

  @override
  String get pleaseSelectTheDateFirst => "Veuillez sélectionner d'abord la date";

  @override
  String get thereAreNoBookings => "Il n'y a pas de réservations répertoriées pour le moment. Gardez une trace de vos réservations ici.";

  @override
  String get payWithFlutterwave => 'Payer avec Flutterwave';

  @override
  String get transactionFailed => 'La transaction a échoué';

  @override
  String get transactionCancelled => 'Transaction annulée';

  @override
  String get flutterwave => 'Flutterwave';

  @override
  String get paytm => 'Paytm';

  @override
  String get areYouSureYouWantToRemove => 'Êtes-vous sûr de vouloir supprimer cet élément';

  @override
  String get remove => 'Retirer';

  @override
  String get you => 'Toi';

  @override
  String get veChanged => 'VE a changé';

  @override
  String get quantityTo => 'Quantité à';

  @override
  String get editAddress => "Modifier l'adresse";

  @override
  String get addNewAddress => 'Ajouter une nouvelle adresse';

  @override
  String get selectCountry => 'Choisissez le pays';

  @override
  String get selectState => "Sélectionnez l'état";

  @override
  String get selectCity => 'Sélectionnez une ville';

  @override
  String get pincode => 'Code PIN';

  @override
  String get addressLine => "Ligne d'adresse";

  @override
  String get writeAddressHere => "Écrire l'adresse ici";

  @override
  String get writeLandmarkHere => 'Écrivez mon point de repère ici';

  @override
  String get saveChanges => 'Sauvegarder les modifications';

  @override
  String get save => 'Sauvegarder';

  @override
  String get cart => 'Chariot';

  @override
  String get yourCartIsEmpty => 'Votre panier est vide';

  @override
  String get thereAreCurrentlyNoItems => "Il n'y a aucun produit dans votre panier actuellement. Commencez à faire du shopping et ajoutez des articles à votre panier.";

  @override
  String get productPriceDetails => 'Détails du prix du produit';

  @override
  String get totalAmount => 'Montant total';

  @override
  String get selectAddress => "Sélectionner l'adresse";

  @override
  String get opps => 'Opinion';

  @override
  String get looksLikeYouHave => "On dirait que vous n'avez pas encore ajouté d'adresse.";

  @override
  String get primary => 'primaire';

  @override
  String get deliverHere => 'Livrer ici';

  @override
  String get areYouSureYouWantToDelete => 'Êtes-vous sûr de vouloir supprimer cette adresse';

  @override
  String get addressDeleteSuccessfully => 'Adressez la suppression avec succès';

  @override
  String get weAreNotShipping => "Nous n'envoyons pas dans votre ville maintenant";

  @override
  String get deliveryCharge => 'Frais de livraison';

  @override
  String get orders => 'Ordres';

  @override
  String get seeYourOrders => 'Voir vos commandes';

  @override
  String get myAddresses => 'Mes adresses';

  @override
  String get manageYourAddresses => 'Gérez vos adresses';

  @override
  String get shop => 'Boutique';

  @override
  String get aboutProduct => 'Sur le produit';

  @override
  String get qty => 'Qté';

  @override
  String get orderDetail => 'Détails de la commande';

  @override
  String get orderDate => 'Date de commande';

  @override
  String get deliveredOn => 'Délivré le';

  @override
  String get deliveryStatus => 'Statut de livraison';

  @override
  String get cancelOrder => 'annuler la commande';

  @override
  String get doYouWantToCancel => 'Voulez-vous annuler cette commande';

  @override
  String get theOrderHasBeenCancelled => 'La commande a été annulée avec succès.';

  @override
  String get noOrdersFound => 'Aucune commande trouvée';

  @override
  String get thereAreNoOrders => "Il n'y a pas de commandes répertoriées pour le moment. Gardez une trace de vos commandes ici.";

  @override
  String get tax => 'Impôt';

  @override
  String get shippingDetail => "Détail d'expédition";

  @override
  String get alternativeContactNumber => 'Numéro de contact alternatif:';

  @override
  String get addReview => 'Ajouter un commentaire';

  @override
  String get thanksYouForReview => 'Merci pour la critique!';

  @override
  String get selectUpToThreeImages => "Sélectionnez jusqu'à trois images!";

  @override
  String get doYouWantToRemove => 'Voulez-vous supprimer cette image';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get customerDetail => 'Détail du client';

  @override
  String get fullName => 'Nom et prénom';

  @override
  String get alternateContactNumber => 'Numéro de contact alternatif';

  @override
  String get orderSummary => 'Récapitulatif de la commande';

  @override
  String get shippingAddress => 'adresse de livraison';

  @override
  String get off => 'désactivé';

  @override
  String get discountedAmount => 'Montant réduit';

  @override
  String get proceed => 'Procéder';

  @override
  String get productReviews => 'Avis sur les produits';

  @override
  String get thanksForVoting => "Merci d'avoir voté";

  @override
  String get bestSellerProduct => 'Produit de best-seller';

  @override
  String get dealsForYou => 'Offres pour vous';

  @override
  String get noProductsFound => 'Aucun produit trouvé';

  @override
  String get featured => 'En vedette';

  @override
  String get readMore => 'En savoir plus';

  @override
  String get readLess => 'Lire moins';

  @override
  String get brand => 'Marque';

  @override
  String get inclusiveOfAllTaxes => 'Y compris toutes les taxes';

  @override
  String get outOfStock => 'En rupture de stock';

  @override
  String get productSize => 'Taille du produit';

  @override
  String get quantity => 'Quantité';

  @override
  String get noRatingsYet => 'Pas encore de notation';

  @override
  String get ratingAndReviews => 'Note et avis';

  @override
  String get totalReviewsAndRatings => 'Revues et notes totales';

  @override
  String get ourMostLoveChewTreats => "Nos friandises à mâcher le plus d'amour";

  @override
  String get allCategories => 'toutes catégories';

  @override
  String get thereAreNoCategories => "Il n'y a pas de catégories pour le moment. Gardez une trace de vos catégories ici.";

  @override
  String get searchForProduct => 'Rechercher un produit';

  @override
  String get atThisTimeThere => "Pour le moment, il n'y a pas de produits ou de catégories disponibles";

  @override
  String get goToCart => 'ALLER AU PANIER';

  @override
  String get addToCart => 'AJOUTER AU PANIER';

  @override
  String get orderSuccessfullyPlaced => 'Commander avec succès placé';

  @override
  String get yorOrderHasBeen => 'Votre ordre a été passé avec succès';

  @override
  String get goToOrderList => 'Aller à la liste de commandes';

  @override
  String get choosePaymentMethod => 'Choisissez le mode de paiement';

  @override
  String get chooseYourConvenientPayment => 'Choisissez votre option de paiement pratique.';

  @override
  String get placeOrder => 'Passer la commande';

  @override
  String get confirmOrder => 'Confirmer la commande';

  @override
  String get doYouConfirmThisPayment => 'Confirmez-vous ce paiement';

  @override
  String get wishlist => 'Liste de souhaits';

  @override
  String get thereAreCurrentlyNoItemsInYourWishlist => "Il n'y a actuellement aucun élément dans votre liste de souhaits. Commencez à ajouter des articles pour lesquels vous aimez les sauver plus tard.";

  @override
  String get price => 'Prix';

  @override
  String get productBrands => 'Marques de produits';

  @override
  String get searchBrand => 'Marque de recherche';

  @override
  String get more => 'Plus';

  @override
  String get rating => 'Notation';

  @override
  String get weight => 'Poids';

  @override
  String get clearFilter => 'Filtre effacer';

  @override
  String get applyFilter => 'Appliquer le filtre';

  @override
  String get orderPlaced => 'Commande passée';

  @override
  String get processing => 'Traitement';

  @override
  String get delivered => 'Livré';

  @override
  String get unpaid => 'Non payé';

  @override
  String get parchasedProducts => 'Produits parchères';

  @override
  String get productAmount => 'Montant du produit';

  @override
  String get filterBy => 'Filtrer par';

  @override
  String get bookingStatus => 'Statut de réservation';

  @override
  String get apply => 'Appliquer';

  @override
  String get searchOrder => 'Ordonnance de recherche';
}
