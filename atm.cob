      ******************************************************************
      * Author: Eliud Waititu                                          *
      * Program Name: Simple ATM Simulation                            *
      * Description: A console-based ATM program implementing secure   *
      *              PIN authentication (3 attempts), account balance  *
      *              management, deposits, and withdrawals with robust *
      *              input validation and formatted currency display.  *
      * Compiler: GnuCOBOL (ANSI COBOL 85 Standard)                    *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SIMPLE-ATM.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *----------------------------------------------------------------*
      * Security and Authentication Variables                          *
      *----------------------------------------------------------------*
       01  WS-SAVED-PIN            PIC X(4) VALUE "1234".
       01  WS-ENTERED-PIN          PIC X(4) VALUE SPACES.
       01  WS-LOGIN-ATTEMPTS       PIC 9(1) VALUE 0.
       01  WS-MAX-ATTEMPTS         PIC 9(1) VALUE 3.
       01  WS-AUTHENTICATED        PIC X    VALUE 'N'.

      *----------------------------------------------------------------*
      * Account Data Variables                                         *
      *----------------------------------------------------------------*
       01  WS-BALANCE              PIC 9(6)V99 VALUE 1000.00.
       01  WS-TRANSACTION-AMT      PIC 9(6)V99 VALUE 0.
       01  WS-MENU-CHOICE          PIC X(1)    VALUE SPACES.

      *----------------------------------------------------------------*
      * Display / Editing Variables                                    *
      *----------------------------------------------------------------*
       01  WS-DISPLAY-BALANCE      PIC $ZZZ,ZZ9.99.
       01  WS-DISPLAY-AMOUNT       PIC $ZZZ,ZZ9.99.
       01  WS-DISPLAY-ATTEMPTS     PIC 9.

       PROCEDURE DIVISION.
      *----------------------------------------------------------------*
      * Entry point: Authenticates user then delegates to menu loop    *
      *----------------------------------------------------------------*
       MAIN-LOGIC.
           PERFORM LOGIN-ROUTINE
           IF WS-AUTHENTICATED = 'Y'
               PERFORM MAIN-MENU-LOOP
           ELSE
               DISPLAY "========================================"
               DISPLAY " ACCOUNT LOCKED: 3 failed attempts.     "
               DISPLAY " Please contact your bank.              "
               DISPLAY "========================================"
           END-IF
           STOP RUN.

      *----------------------------------------------------------------*
      * Handle PIN Login and 3-attempt lockout security                *
      *----------------------------------------------------------------*
       LOGIN-ROUTINE.
           PERFORM UNTIL WS-AUTHENTICATED = 'Y' 
                      OR WS-LOGIN-ATTEMPTS >= WS-MAX-ATTEMPTS
               ADD 1 TO WS-LOGIN-ATTEMPTS
               DISPLAY "========================================"
               DISPLAY "         WELCOME TO WALTON BANK         "
               DISPLAY "========================================"
               DISPLAY "Enter your 4-digit PIN: " WITH NO ADVANCING
               ACCEPT WS-ENTERED-PIN

               IF WS-ENTERED-PIN = WS-SAVED-PIN
                   MOVE 'Y' TO WS-AUTHENTICATED
                   DISPLAY "Login successful! Access granted."
               ELSE
                   COMPUTE WS-DISPLAY-ATTEMPTS = WS-MAX-ATTEMPTS 
                                               - WS-LOGIN-ATTEMPTS
                   DISPLAY "Invalid PIN. Attempts remaining: " 
                           WS-DISPLAY-ATTEMPTS
               END-IF
           END-PERFORM.

      *----------------------------------------------------------------*
      * Main Interactive Menu Loop                                     *
      *----------------------------------------------------------------*
       MAIN-MENU-LOOP.
           PERFORM UNTIL WS-MENU-CHOICE = '4'
               DISPLAY " "
               DISPLAY "========================================"
               DISPLAY "               ATM MENU                 "
               DISPLAY "========================================"
               DISPLAY "[1] Check Balance"
               DISPLAY "[2] Deposit Funds"
               DISPLAY "[3] Withdraw Funds"
               DISPLAY "[4] Exit"
               DISPLAY "----------------------------------------"
               DISPLAY "Enter your choice (1-4): " WITH NO ADVANCING
               ACCEPT WS-MENU-CHOICE

               EVALUATE WS-MENU-CHOICE
                   WHEN '1'
                       PERFORM SHOW-BALANCE
                   WHEN '2'
                       PERFORM PROCESS-DEPOSIT
                   WHEN '3'
                       PERFORM PROCESS-WITHDRAW
                   WHEN '4'
                       DISPLAY "Thank you for banking with us."
                       DISPLAY "Have a great day! Goodbye."
                   WHEN OTHER
                       DISPLAY "Invalid choice. Please select 1 - 4."
               END-EVALUATE
           END-PERFORM.

      *----------------------------------------------------------------*
      * Display Current Account Balance                                *
      *----------------------------------------------------------------*
       SHOW-BALANCE.
           MOVE WS-BALANCE TO WS-DISPLAY-BALANCE
           DISPLAY "----------------------------------------"
           DISPLAY "Current Account Balance: " WS-DISPLAY-BALANCE
           DISPLAY "----------------------------------------".

      *----------------------------------------------------------------*
      * Process Deposit Transaction                                    *
      *----------------------------------------------------------------*
       PROCESS-DEPOSIT.
           DISPLAY "----------------------------------------"
           DISPLAY "Enter amount to deposit: " WITH NO ADVANCING
           ACCEPT WS-TRANSACTION-AMT

           IF WS-TRANSACTION-AMT > 0
               ADD WS-TRANSACTION-AMT TO WS-BALANCE
               MOVE WS-TRANSACTION-AMT TO WS-DISPLAY-AMOUNT
               MOVE WS-BALANCE TO WS-DISPLAY-BALANCE
               DISPLAY "Successfully deposited: " WS-DISPLAY-AMOUNT
               DISPLAY "Updated Balance:        " WS-DISPLAY-BALANCE
           ELSE
               DISPLAY "Error: Deposit must be greater than zero."
           END-IF
           DISPLAY "----------------------------------------".

      *----------------------------------------------------------------*
      * Process Withdrawal Transaction with Sufficiency Check          *
      *----------------------------------------------------------------*
       PROCESS-WITHDRAW.
           DISPLAY "----------------------------------------"
           DISPLAY "Enter amount to withdraw: " WITH NO ADVANCING
           ACCEPT WS-TRANSACTION-AMT

           IF WS-TRANSACTION-AMT <= 0
               DISPLAY "Error: Amount must be greater than zero."
           ELSE
               IF WS-TRANSACTION-AMT <= WS-BALANCE
                   SUBTRACT WS-TRANSACTION-AMT FROM WS-BALANCE
                   MOVE WS-TRANSACTION-AMT TO WS-DISPLAY-AMOUNT
                   MOVE WS-BALANCE TO WS-DISPLAY-BALANCE
                   DISPLAY "Successfully withdrew: " WS-DISPLAY-AMOUNT
                   DISPLAY "Updated Balance:       " WS-DISPLAY-BALANCE
               ELSE
                   MOVE WS-TRANSACTION-AMT TO WS-DISPLAY-AMOUNT
                   MOVE WS-BALANCE TO WS-DISPLAY-BALANCE
                   DISPLAY "Error: Insufficient funds!"
                   DISPLAY "Requested:         " WS-DISPLAY-AMOUNT
                   DISPLAY "Available Balance: " WS-DISPLAY-BALANCE
               END-IF
           END-IF
           DISPLAY "----------------------------------------".
