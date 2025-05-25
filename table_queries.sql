-- 1. Users
CREATE TABLE Users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(255),
  role ENUM('user', 'admin') DEFAULT 'user'
);
INSERT INTO Users (name, email, password, role)
VALUES 
('Sabbir', 'sabbir@email.com', 'sabbir123', 'admin'), 
('Charlie', 'charlie@email.com', 'charlie123', 'user'),
('David', 'david@email.com', 'david123', 'user'),
('Eve', 'eve@email.com', 'eve123', 'user'),     
('Elina', 'elina@email.com', 'elina123', 'user'),
('George', 'george@email.com', 'george123', 'user'),
('Harry', 'harry@email.com', 'harry123', 'user'),
('Ivy', 'ivy@email.com', 'ivy123', 'user');

-- 2. Currencies
CREATE TABLE Currencies (
  currency_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  symbol VARCHAR(10)
);
INSERT INTO Currencies (name, symbol)
VALUES 
('Bitcoin', 'BTC'),
('Ethereum', 'ETH'),
('BNB', 'BNB'),
('Solana', 'SOL'),
('Litecoin', 'LTC'),
('Tron', 'TRX');

-- 3. Wallets
CREATE TABLE Wallets (
  wallet_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  currency_id INT,
  address VARCHAR(100) UNIQUE,
  balance DECIMAL(18,4) DEFAULT 0.0,
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (currency_id) REFERENCES Currencies(currency_id)
);
INSERT INTO Wallets (user_id, currency_id, address, balance)
VALUES 
(4, 1, 'BTC_WALLET_004', 3.0),
(5, 2, 'ETH_WALLET_003', 15.2),
(6, 4, 'SOL_WALLET_001', 7.0),
(7, 3, 'BNB_WALLET_002', 1.2),
(8, 1, 'BTC_WALLET_005', 0.8),
(1, 1, 'BTC_WALLET_001', 5.0),
(2, 1, 'BTC_WALLET_002', 2.0),
(3, 3, 'BNB_WALLET_001', 10.0); 

-- 4. Transactions
CREATE TABLE Transactions (
  tx_id INT PRIMARY KEY AUTO_INCREMENT,
  sender_wallet_id INT,
  receiver_wallet_id INT,
  currency_id INT,
  amount DECIMAL(18,4),
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(50),
  FOREIGN KEY (sender_wallet_id) REFERENCES Wallets(wallet_id),
  FOREIGN KEY (receiver_wallet_id) REFERENCES Wallets(wallet_id),
  FOREIGN KEY (currency_id) REFERENCES Currencies(currency_id)
);
INSERT INTO Transactions (sender_wallet_id, receiver_wallet_id, currency_id, amount, status)
VALUES 
(1, 5, 1, 0.2, 'Completed'),
(3, 4, 1, 1.0, 'Completed'),
(6, 8, 4, 0.5, 'Completed'),
(4, 2, 1, 0.7, 'Pending'),
(5, 1, 2, 1.5, 'Completed'),
(2, 7, 1, 0.1, 'Pending');

-- 5. AuditLogs
CREATE TABLE AuditLogs (
  log_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  action TEXT,
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  details TEXT,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
INSERT INTO AuditLogs (user_id, action, details)
VALUES 
(4, 'Created Wallet', 'Created BTC_WALLET_004'),
(5, 'Sent 0.2 BTC', 'From wallet 1 to wallet 5'),
(6, 'Transferred 0.5 SOL', 'From wallet 6 to wallet 8'),
(7, 'Logged In', 'Logged in from mobile'),
(8, 'Received 0.5 SOL', 'To wallet 8 from wallet 6');

-- 6. Notifications 
CREATE TABLE Notifications (
  notification_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  message TEXT,
  is_read BOOLEAN DEFAULT FALSE,
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
INSERT INTO Notifications (user_id, message)
VALUES 
(4, 'Your withdrawal of 1.2 LTC has been processed.'),
(5, 'You received 200 ADA in your wallet.'),
(6, '0.3 ETH has been sent from your wallet.'),
(7, 'Your transaction of 15 XRP is pending approval.'),
(8, 'New device login detected.'),
(2, 'You received 10 DOGE from user George.'),
(3, 'Network congestion detected. Expect minor delays.'),
(1, 'You have successfully staked 50 MATIC.');

-- 7. TransactionFees
CREATE TABLE TransactionFees (
  fee_id INT PRIMARY KEY AUTO_INCREMENT,
  currency_id INT,
  fee_percent DECIMAL(5,2),  -- e.g., 1.50 = 1.5%
  FOREIGN KEY (currency_id) REFERENCES Currencies(currency_id)
);
INSERT INTO TransactionFees (currency_id, fee_percent)
VALUES 
(1, 1.50),  -- Bitcoin
(2, 2.00),  -- Ethereum
(3, 0.75),  -- BNB
(4, 1.20),  -- Solana
(5, 0.60),  -- Litecoin
(6, 0.70); -- Tron

-- 8. AddressGenerationLogs
CREATE TABLE AddressGenerationLogs (
  log_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  currency_id INT,
  generated_address VARCHAR(100),
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (currency_id) REFERENCES Currencies(currency_id)
);
INSERT INTO AddressGenerationLogs (user_id, currency_id, generated_address)
VALUES 
(2, 1, 'BTC_WALLET_001'),
(3, 2, 'ETH_WALLET_003'),
(4, 3, 'BNB_WALLET_001'),
(5, 5, 'LTC_WALLET_001'),
(6, 3, 'BNB_WALLET_002'),
(7, 4, 'SOL_WALLET_001'),
(3, 6, 'TRX_WALLET_001');