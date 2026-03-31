// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'SIGRA';

  @override
  String get appSubtitle => 'La Molienda Residences';

  @override
  String get appTitle => 'SIGRA - La Molienda';

  @override
  String get apartmentLabel => 'Apartment';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'LOG IN';

  @override
  String get registerLink => 'Don\'t have an account? Register here';

  @override
  String get developedBy => 'Developed by...';

  @override
  String get registerTitle => 'SIGRA Registration';

  @override
  String get registerSubtitle => 'Create your resident account';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get cedulaLabel => 'ID Number';

  @override
  String get towerApartmentLabel => 'Tower / Apartment';

  @override
  String get emailLabel => 'Email';

  @override
  String get registerButton => 'REGISTER';

  @override
  String get registerDescription => 'Fill in your details to register';

  @override
  String get welcomeMessage => 'Welcome';

  @override
  String get homeAdminTitle => 'SIGRA - Admin Dashboard';

  @override
  String get homeResidentTitle => 'SIGRA - My Dashboard';

  @override
  String get adminSectionTitle => 'Administrative Control Panel';

  @override
  String get residentSectionTitle => 'Services & Management';

  @override
  String get modeResident => 'Resident Mode';

  @override
  String get modeAdmin => 'Admin Mode';

  @override
  String get menuPay => 'Pay';

  @override
  String get menuHistory => 'History';

  @override
  String get menuReservations => 'Reservations';

  @override
  String get menuVisitors => 'Visitors';

  @override
  String get menuMaintenance => 'Requests';

  @override
  String get menuVoting => 'Voting';

  @override
  String get menuAnnouncements => 'Announcements';

  @override
  String get menuRules => 'Regulations';

  @override
  String get menuReports => 'Reports';

  @override
  String get menuEmergency => 'Emergency';

  @override
  String get adminRecaudation => 'Total Monthly Revenue';

  @override
  String get adminCajaLabel => 'La Molienda Residence Fund';

  @override
  String get residentAccountStatus => 'Account Status';

  @override
  String get residentPendingLabel => 'Pending - January 2026';

  @override
  String get paymentTitle => 'Report Payment';

  @override
  String get transactionDetails => 'Transaction Details';

  @override
  String get paymentMethodLabel => 'Payment Method';

  @override
  String get methodTransfer => 'Bank Transfer';

  @override
  String get methodMobilePay => 'Mobile Payment';

  @override
  String get methodZelle => 'Zelle';

  @override
  String get methodCash => 'Cash';

  @override
  String get referenceNumberLabel => 'Reference Number';

  @override
  String get amountLabel => 'Amount (\$)';

  @override
  String get attachReceipt => 'Attach Receipt';

  @override
  String get sendReportButton => 'SEND REPORT';

  @override
  String get paymentSuccessMessage =>
      'Your payment report has been successfully sent to the condo board. It will be validated within the next 24 hours.';

  @override
  String get understoodButton => 'UNDERSTOOD';

  @override
  String get paymentHistoryAdminTitle => 'Payment Registry';

  @override
  String get paymentHistoryResidentTitle => 'Payment History';

  @override
  String get collectedThisMonth => 'Collected\nthis month';

  @override
  String get toCollect => 'To collect';

  @override
  String get defaulters => 'Defaulters';

  @override
  String get totalPaid => 'Total paid';

  @override
  String get pending => 'Pending';

  @override
  String get searchByApartment => 'Search by apartment';

  @override
  String get searchHintApt => 'E.g.: 4-B';

  @override
  String get filterAll => 'All';

  @override
  String get filterApproved => 'Approved';

  @override
  String get filterPending => 'Pending';

  @override
  String get filterRejected => 'Rejected';

  @override
  String get noPaymentsMatch => 'No payments match the filter';

  @override
  String get statusApproved => 'Approved';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusRejected => 'Rejected';

  @override
  String aptLabel(String apartment) {
    return 'Apt $apartment';
  }

  @override
  String refLabel(String reference) {
    return 'Ref: $reference';
  }

  @override
  String get defaultPaymentDesc => 'Payment';

  @override
  String get reservationsTitle => 'La Molienda Reservations';

  @override
  String get statusAvailable => 'Available';

  @override
  String get statusOccupied => 'Occupied';

  @override
  String get statusMaintenance => 'Under Maintenance';

  @override
  String get reserveButton => 'RESERVE';

  @override
  String get reservationSentTitle => 'Reservation Sent';

  @override
  String reservationSentMessage(String areaName, String date) {
    return 'Your reservation request for \"$areaName\" on $date has been sent for approval.';
  }

  @override
  String get acceptButton => 'ACCEPT';

  @override
  String get announcementsTitle => 'La Molienda Announcements';

  @override
  String get urgentLabel => 'URGENT!';

  @override
  String get noticeLabel => 'NOTICE';

  @override
  String get rulesTitle => 'La Molienda Regulations';

  @override
  String get rulesBanner =>
      'Community Regulations in effect for the year 2026.';

  @override
  String get profileTitle => 'My Profile';

  @override
  String ownerInfo(String apartment) {
    return 'Owner: Apt $apartment';
  }

  @override
  String get emailInfoLabel => 'Email';

  @override
  String get phoneInfoLabel => 'Phone';

  @override
  String get solvencyStatusLabel => 'Solvency Status';

  @override
  String get solvencyStatusValue => 'SOLVENT';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get changePassword => 'Change Password';

  @override
  String get logoutButton => 'LOG OUT';

  @override
  String get chatbotTitle => 'SIGRA Virtual Assistant';

  @override
  String get chatbotGreeting =>
      'Hello! I\'m SIGRA-Bot, your virtual assistant. How can I help you today?';

  @override
  String get chatbotPaymentMethods =>
      'We accept: \n• Bank Transfer (Banesco)\n• Mobile Payment\n• Zelle\n• Cash at the office.\n\nWhen paying, remember to upload your receipt in the \'Pay\' module from the main menu.';

  @override
  String get chatbotGenericFollowup =>
      'Understood. Is there anything else I can help you with?';

  @override
  String get chatbotReservationGuide =>
      'Perfect! To make a reservation:\n1. Go to the \'Reservations\' menu.\n2. Select the area (Pool, BBQ, etc.).\n3. Choose the date.\n\nNote: Some areas require a \$20 security deposit. Would you like to see the area usage rules?';

  @override
  String get chatbotReservationReminder =>
      'Sure. Remember that reservations must be made at least 48 hours in advance.';

  @override
  String get chatbotAreaRules =>
      'The main rules are: \n• No loud music.\n• Maximum 15 guests.\n• Area must be left clean.\n\nWould you like help with anything else?';

  @override
  String get chatbotEventWish => 'Got it. Enjoy your event!';

  @override
  String get chatbotPaymentStatus =>
      'Your apartment (4-B) has a pending balance of \$45.00 (January). Would you like to see the available payment methods?';

  @override
  String get chatbotTechnicalStatus =>
      'There is an active report about the water pump. Technical staff is already working on site. Service is expected to be restored by 4:00 PM.';

  @override
  String get chatbotReservationAvailable =>
      'The reservation module is available for the BBQ Area and the Party Hall. Would you like me to explain the step-by-step process?';

  @override
  String get chatbotRulesQuery =>
      'La Molienda regulations prohibit loud noise after 8:00 PM. Pets must always be on a leash. Would you like to check a specific article?';

  @override
  String get chatbotIntro =>
      'Hello! I\'m SIGRA-Bot. I\'m ready to help you manage your apartment. What do you need?';

  @override
  String get chatbotCourtesy => 'Always at your service! Anything else?';

  @override
  String get chatbotCapabilities =>
      'I can provide information about your payments, report technical issues, help with reservations, or read the building regulations.';

  @override
  String get chatbotError =>
      'I couldn\'t process that request. Try asking me about \'payments\', \'technical issues\' or \'reservations\'.';

  @override
  String get quickReplyDebt => 'How much do I owe?';

  @override
  String get quickReplyWaterIssue => 'Water issue';

  @override
  String get quickReplyReserveArea => 'Reserve areas';

  @override
  String get quickReplyNoiseRules => 'Noise rules';

  @override
  String get typingIndicator => 'Typing...';

  @override
  String get chatInputHint => 'Write a message...';

  @override
  String get creditsTitle => 'Development Team';

  @override
  String get teamMembersSection => 'Team Members';

  @override
  String get tutorSection => 'Academic Advisor';

  @override
  String get scanProfile => 'Scan to view their profile';

  @override
  String get closeButton => 'Close';

  @override
  String get copyrightNotice => '© 2026 UNEXCA';

  @override
  String profileOf(String name) {
    return 'Profile of $name';
  }

  @override
  String get visitorsAdminTitle => 'Visitor Control';

  @override
  String get visitorsResidentTitle => 'My Visitors';

  @override
  String get searchLabel => 'Search';

  @override
  String get searchVisitorHint => 'Visitor name or apartment...';

  @override
  String get todayLabel => 'Today';

  @override
  String get inBuildingLabel => 'In building';

  @override
  String get pendingLabel => 'Pending';

  @override
  String get visitorStatusPending => 'Pending';

  @override
  String get visitorStatusApproved => 'Approved';

  @override
  String get visitorStatusInBuilding => 'In building';

  @override
  String get visitorStatusExited => 'Left';

  @override
  String get visitorStatusRejected => 'Rejected';

  @override
  String get noVisitorsFound => 'No visitors found';

  @override
  String get noVisitorsRegistered => 'You have no registered visitors';

  @override
  String accessCodeLabel(String code) {
    return 'Access code: $code';
  }

  @override
  String get approveButton => 'Approve';

  @override
  String get rejectButton => 'Reject';

  @override
  String get approveVisitorTitle => 'Approve Visitor';

  @override
  String get rejectVisitorTitle => 'Reject Visitor';

  @override
  String visitorActionConfirm(String action, String name, String apartment) {
    return 'Are you sure you want to $action the visit of \"$name\" to apartment $apartment?';
  }

  @override
  String get cancelButton => 'CANCEL';

  @override
  String get approveButtonUpper => 'APPROVE';

  @override
  String get rejectButtonUpper => 'REJECT';

  @override
  String visitorActionSuccess(String status) {
    return 'Visitor $status successfully';
  }

  @override
  String get registerVisitorTitle => 'Register Visitor';

  @override
  String get visitorNameLabel => 'Full name';

  @override
  String get visitorCedulaLabel => 'ID Number (V-XX.XXX.XXX)';

  @override
  String get visitorNameRequired => 'Enter visitor\'s name';

  @override
  String get visitorCedulaRequired => 'Enter visitor\'s ID number';

  @override
  String get expectedDateLabel => 'Expected date';

  @override
  String get vehiclePlateLabel => 'Vehicle plate (optional)';

  @override
  String get notesOptionalLabel => 'Notes (optional)';

  @override
  String get registerVisitorButton => 'Register Visitor';

  @override
  String get visitorRegisteredSuccess => 'Visitor registered successfully';

  @override
  String get maintenanceAdminTitle => 'Request Management';

  @override
  String get maintenanceResidentTitle => 'My Requests';

  @override
  String get categoryPlumbing => 'Plumbing';

  @override
  String get categoryElectrical => 'Electrical';

  @override
  String get categoryElevator => 'Elevator';

  @override
  String get categoryCommonAreas => 'Common Areas';

  @override
  String get categoryStructural => 'Structural';

  @override
  String get categorySecurity => 'Security';

  @override
  String get categoryOther => 'Other';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityMedium => 'Medium';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityUrgent => 'Urgent';

  @override
  String get statusOpen => 'Open';

  @override
  String get statusInProgress => 'In Progress';

  @override
  String get statusResolved => 'Resolved';

  @override
  String get statusClosed => 'Closed';

  @override
  String adminStatsOpen(int count) {
    return 'Open: $count';
  }

  @override
  String adminStatsInProgress(int count) {
    return 'In progress: $count';
  }

  @override
  String adminStatsUrgent(int count) {
    return 'Urgent: $count';
  }

  @override
  String get filterOpen => 'Open';

  @override
  String get filterInProgress => 'In Progress';

  @override
  String get filterResolved => 'Resolved';

  @override
  String get noRequestsFilter => 'No requests match this filter';

  @override
  String get noRequestsRegistered => 'You have no registered requests';

  @override
  String get newRequestTitle => 'New Request';

  @override
  String get categoryLabel => 'Category';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get titleLabel => 'Title';

  @override
  String get titleHint => 'E.g.: Water leak in the kitchen';

  @override
  String get titleRequired => 'Enter a title';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionHint => 'Describe the problem in detail...';

  @override
  String get descriptionRequired => 'Enter a description';

  @override
  String get attachPhotos => 'Attach photos (coming soon)';

  @override
  String get sendRequestButton => 'Submit Request';

  @override
  String get requestSentSuccess => 'Request submitted successfully';

  @override
  String get statusLabel => 'Status';

  @override
  String get assignToLabel => 'Assign to';

  @override
  String get assignToHint => 'Name of the responsible person';

  @override
  String get adminNotesLabel => 'Admin notes';

  @override
  String get adminNotesHint => 'Internal observations...';

  @override
  String get saveButton => 'SAVE';

  @override
  String get requestUpdatedSuccess => 'Request updated';

  @override
  String assignedTo(String name) {
    return 'Assigned to: $name';
  }

  @override
  String get votingAdminTitle => 'Voting Management';

  @override
  String get votingResidentTitle => 'Voting';

  @override
  String get tabActive => 'Active';

  @override
  String get tabClosed => 'Closed';

  @override
  String get tabUpcoming => 'Upcoming';

  @override
  String get noActivePolls => 'No active polls';

  @override
  String get noClosedPolls => 'No closed polls';

  @override
  String get noUpcomingPolls => 'No upcoming polls';

  @override
  String get createPollTitle => 'Create New Poll';

  @override
  String get pollTitleLabel => 'Title';

  @override
  String get pollDescriptionLabel => 'Description';

  @override
  String get optionsLabel => 'Options';

  @override
  String optionNumber(int number) {
    return 'Option $number';
  }

  @override
  String get addOptionButton => 'Add option';

  @override
  String get startDateLabel => 'Start';

  @override
  String get endDateLabel => 'End';

  @override
  String get createPollButton => 'CREATE POLL';

  @override
  String get voteRegisteredSuccess => 'Vote registered successfully';

  @override
  String get pollCreatedSuccess => 'Poll created successfully';

  @override
  String get pollStatusActive => 'Active';

  @override
  String get pollStatusClosed => 'Closed';

  @override
  String get pollStatusUpcoming => 'Coming soon';

  @override
  String pollStartsOn(String date) {
    return 'Starts: $date';
  }

  @override
  String pollEndsOn(String date) {
    return 'Ends: $date';
  }

  @override
  String get voteButton => 'VOTE';

  @override
  String voteResults(int votes, String percentage) {
    return '$votes ($percentage%)';
  }

  @override
  String participationActive(int count) {
    return '$count/50 residents have voted';
  }

  @override
  String get closePollButton => 'Close poll';

  @override
  String participationClosed(int count) {
    return '$count/50 residents voted';
  }

  @override
  String get emergencyTitle => 'Emergency Contacts';

  @override
  String get emergencyBanner => 'In case of emergency, contact immediately';

  @override
  String get emergencySection => 'Emergencies';

  @override
  String get buildingSection => 'Building';

  @override
  String get technicalSection => 'Technical Services';

  @override
  String callingTo(String name) {
    return 'Calling $name...';
  }

  @override
  String get available24h => '24h';

  @override
  String get reportsAdminTitle => 'SIGRA Reports Panel';

  @override
  String get reportsResidentTitle => 'My Statistics';

  @override
  String get reportsAdminHeading => 'La Molienda Management Summary';

  @override
  String get reportsResidentHeading => 'Your Condo Activity';

  @override
  String get expenseBreakdownTitle => 'Expense Breakdown';

  @override
  String get monthlyCollectionTitle => 'Monthly Collection';

  @override
  String get chatbotTopicsTitle => 'Most Consulted Chatbot Topics';

  @override
  String get chatLogsTitle => 'Recent Chatbot Reports';

  @override
  String get collectedLabel => 'Collected';

  @override
  String get pendingLegendLabel => 'Pending';

  @override
  String get resolvedByAI => 'Resolved by AI';

  @override
  String get escalatedToBoard => 'Escalated to Board';

  @override
  String get adminInsight =>
      'Suggestion: The volume of questions about \'Payments\' indicates that the help button should be more visible.';

  @override
  String get residentInsight =>
      'Thank you for your good standing. This enables the maintenance of common areas.';

  @override
  String get notificationMessage =>
      'You have a new announcement: Scheduled water outage';

  @override
  String get navHome => 'Home';

  @override
  String get navPayments => 'Payments';

  @override
  String get navCommunity => 'Community';

  @override
  String get navServices => 'Services';

  @override
  String get navProfile => 'Profile';

  @override
  String get paymentsHubTitle => 'Payments';

  @override
  String get reportPayment => 'Report Payment';

  @override
  String get reportPaymentDesc => 'Register a new payment made';

  @override
  String get paymentHistoryTitle => 'Payment History';

  @override
  String get paymentHistoryDesc => 'Check your previous payments';

  @override
  String get communityHubTitle => 'Community';

  @override
  String get announcementsDesc => 'Building news and announcements';

  @override
  String get votingDesc => 'Participate in decisions';

  @override
  String get rulesDesc => 'Community regulations';

  @override
  String get visitorsDesc => 'Manage visitor access';

  @override
  String get servicesHubTitle => 'Services';

  @override
  String get maintenanceDesc => 'Report problems or issues';

  @override
  String get reservationsDesc => 'Reserve common areas';

  @override
  String get emergencyDesc => 'Important contact numbers';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get viewAll => 'View all';

  @override
  String get chatbot => 'Chatbot';

  @override
  String get reserve => 'Reserve';

  @override
  String get report => 'Report';

  @override
  String get activityPaymentApproved => 'Payment approved';

  @override
  String get activityReservationSent => 'Reservation sent';

  @override
  String get activityNewAnnouncement => 'New announcement';

  @override
  String get activityPaymentAmount => '\$150.00';

  @override
  String get activityReservationArea => 'Central BBQ Area';

  @override
  String get activityAnnouncementText => 'Scheduled water outage';

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get adminQuickMorosos => 'Defaulters';

  @override
  String get adminQuickSolicitudes => 'Requests';

  @override
  String get adminQuickAnuncios => 'Announcements';

  @override
  String get adminQuickReportes => 'Reports';

  @override
  String get adminActivityPaymentReceived => 'Payment received';

  @override
  String get adminActivityPaymentApt => 'Apt 3-A - Transfer';

  @override
  String get adminActivityNewRequest => 'New request';

  @override
  String get adminActivityRequestText => 'Water leak - Apt 7-C';

  @override
  String get adminActivityPollClosed => 'Poll closed';

  @override
  String get adminActivityPollText => 'Facade painting - 38 votes';

  @override
  String get adminBadge => 'Administrator';
}
