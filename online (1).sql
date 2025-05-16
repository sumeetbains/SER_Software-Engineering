create database online;
use online;

CREATE TABLE MembershipTypes (
    membership_type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(100) NOT NULL
);

CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255),
    membership_type_id INT,
    registration_date DATE,
    approved BOOLEAN DEFAULT FALSE,
    dashboard_data TEXT,
    FOREIGN KEY (membership_type_id) REFERENCES MembershipTypes(membership_type_id)
);

CREATE TABLE Admins (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password_hash VARCHAR(255)
);

CREATE TABLE Interests (
    interest_id INT PRIMARY KEY AUTO_INCREMENT,
    interest_name VARCHAR(100)
);

CREATE TABLE MemberInterests (
    member_id INT,
    interest_id INT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(member_id, interest_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (interest_id) REFERENCES Interests(interest_id)
);

CREATE TABLE Events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    description TEXT,
    event_date DATETIME,
    created_by INT,
    FOREIGN KEY (created_by) REFERENCES Admins(admin_id)
);

CREATE TABLE EventBookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    event_id INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE DigitalContentModules (
    module_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255),
    description TEXT,
    content_url TEXT
);

CREATE TABLE ModuleBookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    module_id INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (module_id) REFERENCES DigitalContentModules(module_id)
);

CREATE TABLE Tags (
    tag_id INT PRIMARY KEY AUTO_INCREMENT,
    tag_name VARCHAR(50)
);

CREATE TABLE MemberTags (
    member_id INT,
    tag_id INT,
    PRIMARY KEY (member_id, tag_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (tag_id) REFERENCES Tags(tag_id)
);

CREATE TABLE VisitLogs (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    person_type ENUM('member', 'non-member'),
    person_id INT,
    event_id INT,
    visit_date DATETIME,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

CREATE TABLE ConnectionsBoardPosts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    post_type ENUM('need', 'offer'),
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

CREATE TABLE Chats (
    chat_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    message TEXT,
    sent_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES Members(member_id),
    FOREIGN KEY (receiver_id) REFERENCES Members(member_id)
);

CREATE TABLE InterestHistory (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    old_interest TEXT,
    new_interest TEXT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);
