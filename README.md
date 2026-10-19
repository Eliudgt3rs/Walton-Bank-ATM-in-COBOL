# WALTON BANK ATM 🏦

A professional, console-based ATM simulation written in **COBOL** (ANSI COBOL 85). This program simulates a real-world banking machine experience, including secure PIN authentication, balance management, and transaction validation.

## 🌟 Features

- **Secure Login:** PIN-based authentication with a maximum of 3 attempts before account lockout.
- **Check Balance:** Real-time display of your current account funds with professional currency formatting.
- **Deposit Funds:** Add money to your account with built-in validation to ensure positive deposit amounts.
- **Withdraw Funds:** Securely withdraw money with automatic "Insufficient Funds" checks to prevent overdrafts.
- **Data Integrity:** Uses standard COBOL Picture clauses (PIC) for high-precision financial calculations.

## 🛠️ Technical Specifications

- **Language:** COBOL (Standard: ANSI-85)
- **Compiler:** GnuCOBOL (Open Source)
- **Input Handling:** Interactive console/terminal interface.

## 🚀 Getting Started

### Prerequisites

You will need the **GnuCOBOL** compiler installed on your system.

### Compilation

To compile the source code into an executable program, use the following command in your terminal:

```bash
cobc -x -std=cobol85 atm.cob
```

*Note: On Windows systems using GnuCOBOL via Chocolatey, you may need to run this within the `set_env.cmd` environment.*

### Running the Program

Run the compiled binary:

**Windows:**
```powershell
.\atm.exe
```

**Linux/macOS:**
```bash
./atm
```

## 🔐 Default Credentials

For testing purposes, the program is initialized with:
- **Default PIN:** `1234`
- **Starting Balance:** `$1,000.00`

## 📂 Project Structure

- `atm.cob`: The human-readable COBOL source code.
- `README.md`: Project documentation (this file).

---
*Developed as a demonstration of legacy system architecture and modern financial logic.*
