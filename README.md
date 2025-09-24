# 🐾 Digital Pet App (State Management in Flutter)

## 📌 Project Overview
This project is an **In-Class Activity #5** for the Mobile Application Development (MAD) course.  
The objective is to create a **Digital Pet Simulation** using **Flutter State Management** (`StatefulWidget` + `setState`).  

Users can:
- Feed the pet
- Play with the pet
- See mood updates (Happy, Neutral, Unhappy)
- Watch hunger increase over time
- Manage energy through activities
- Reach win/loss conditions

---

## 🎯 Features Implemented
### Part (1) – Core Features
- ✅ Dynamic Pet Color Change (Green/Yellow/Red based on happiness level)  
- ✅ Mood Indicator with Emoji (😊 / 😐 / 😢)  
- ✅ Pet Name Customization (enter name before starting)  
- ✅ Hunger increases automatically over time (Timer every 30 sec)  
- ✅ Win/Loss Conditions:
  - Win → Happiness > 80
  - Loss → Hunger = 100 & Happiness ≤ 10  

### Part (2) – Additional Features (Graduate Requirement: 3/4, Implemented All 4)
- ✅ Energy Bar (LinearProgressIndicator)  
- ✅ Energy Logic (activities increase/decrease energy)  
- ✅ Activity Selection (Nap, Walk, Sing via dropdown)  
- ✅ Pet State Updates (activities affect hunger, happiness, energy)  

---

## 🚀 How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/digital-pet-app.git
   cd digital-pet-app
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
4. Build APK for submission:
   ```bash
   flutter build apk --release
   ```
   The APK will be generated at:
   ```
   build/app/outputs/flutter-apk/app-release.apk
   ```

---
