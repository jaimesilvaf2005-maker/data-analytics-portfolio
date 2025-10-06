# 🔢 Program 2 – Character to Digit Converter

## 📘 Overview
This Python program takes a phone number that may include **letters and digits**, and converts every **alphabetic character into its corresponding digit** based on the standard telephone keypad layout.  
It was developed as part of a **Programming Fundamentals** assignment to practice **functions, conditional statements, loops**, and **string manipulation** in Python.

---

## ⚙️ How It Works
The program prompts the user to enter a phone number (e.g., `555-GET-FOOD`) and then converts any letters into their respective numeric values according to the telephone keypad.

### 📈 Conversion Reference
| Letters | Digit |
|----------|--------|
| A, B, C | 2 |
| D, E, F | 3 |
| G, H, I | 4 |
| J, K, L | 5 |
| M, N, O | 6 |
| P, Q, R, S | 7 |
| T, U, V | 8 |
| W, X, Y, Z | 9 |

---

## 🧩 IPO (Input – Processing – Output)
1. **Input:** A string representing a phone number that may contain digits, letters, and hyphens (e.g., `1-800-FLOWERS`).  
2. **Processing:**  
   - The program reads each character.  
   - If the character is a letter, it converts it into its corresponding digit.  
   - Non-letter characters (digits, spaces, hyphens) are kept unchanged.  
3. **Output:** The complete phone number with all letters replaced by digits.

---

## 💻 Example Execution
```text
Enter a phone number: 555-GET-FOOD
Converted phone number: 555-438-3663
```

---

## 🧠 Key Concepts Practiced
- Defining and calling **functions** in Python  
- Using **conditional logic (`if`, `elif`, `else`)**  
- Looping through strings  
- Applying **string methods** like `.lower()`  
- Clean and readable code organization in **Jupyter Notebook**

---

## 🧰 Technologies Used
- Python 3  
- Jupyter Notebook (.ipynb)

---

## 🧑‍💻 Author
**Jaime Silva**  
📍 Franklin College – Programming Fundamentals  
📆 2025  

---

## 🏁 How to Run
1. Clone or download this repository.  
2. Open the notebook `Program2.ipynb` in **Jupyter Notebook** or **VS Code with Jupyter extension**.  
3. Run all cells and enter a phone number when prompted.

---

## 🏷️ License
This project is for educational purposes. You are free to explore and adapt it for learning.
