# stridex
<img width="1024" height="1536" alt="Image" src="https://github.com/user-attachments/assets/139ba940-48dd-4d11-b566-5530a8f58e78" />
<img width="1024" height="1536" alt="Image" src="https://github.com/user-attachments/assets/e10bb94e-0c03-481e-b656-06769d560af9" />

## 📜 Description
StrideX is a premium, lightweight health and fitness application built with Flutter. It features a sophisticated dynamic theme engine with full support for Light and Dark modes, ensuring a high-end user experience. Built on Clean Architecture, the app provides a modular structure while maintaining a very small footprint (only 20.0 MB). It transforms raw pedometer data into actionable health insights through beautiful, responsive analytics

## 🎦 Video Demonstration
🎥 [Watch App Demo]()

## 📱 Screenshot
![Image](https://github.com/user-attachments/assets/12dd07b4-3680-449c-92e3-cb031ff6bb6f)
![Image](https://github.com/user-attachments/assets/24fb7fc1-bd20-4835-9fcb-ac16f083081e)
![Image](https://github.com/user-attachments/assets/7c54a8bb-2b41-479b-9a89-059464a04e3a)
![Image](https://github.com/user-attachments/assets/06cf145d-d035-4a03-aefd-303f6442c7a2)
![Image](https://github.com/user-attachments/assets/eb7e1acc-9e7e-4656-8680-860211d69810)
![Image](https://github.com/user-attachments/assets/73827120-f760-4d29-9a35-4851cb3c285f)
![Image](https://github.com/user-attachments/assets/49bc5167-7f27-4c5c-84c6-1cc93c710025)
![Image](https://github.com/user-attachments/assets/ed58df5b-cf16-4aaa-a52f-f3502c2fe7d3)


## 🚀 Features
- Adaptive Theme System: Professional implementation of Light and Dark modes with custom color palettes and text styles
- Real-time Step Counting: Leverages the hardware pedometer sensor for low-power, accurate real-time tracking.
- Advanced Analytics: Provides visual representations (daily/weekly/monthly) of activity data to track progress over time.
- Personalized Calibration: Allows users to input physical metrics (height, weight, gender, age) to calculate precise health statistics.
- Data Persistence: Uses a local database to store historical activity, ensuring user progress is never lost.
- Activity History: A dedicated section to review past performance and hit milestones.
- Permission Management: Robust handling of physical activity permissions across different Android and iOS versions.
- Notifications: Local alerts and reminders to keep users engaged with their fitness goals.
- Modern UI/UX: A responsive design utilizing Lottie animations, SVG icons, and custom styling for a premium feel.



## 🔨 Technologies Used

| **Aspect**                    | **Details**                                           |
|-------------------------------|-------------------------------------------------------|
| **Framework**                 | Flutter                                               |
| **State Management**          | Cubit  & provider                                     |
| **Architecture**              | Clean Architecture(Data, Domain, Presentation layers) |
| **Local DB**                  | Sqflite  &  shared_preferences                        |
| **Device Senseor**            | Pedometer (Hardware Step Counter)                     |
| **Dependency Injection**      | Get_It)                                               |
| **Navigation**                | Go_Router                                             |
| **UI/UX Utilities**           | Flutter_ScreenUtil, Lottie, Flutter_SVG               |
| **Functional Logic**          | Dartz (Either/Functional Programming)                 |
| **Notifications**             | Flutter_local_notifications                           |
| **Theming**                   | Dynamic Light & Dark Mode                             |


## 📜Summary of Architecture:
 The project is organized into a core directory (for shared services, DI, and utilities) and a features directory. Each feature (like step_counter or analytics) is further divided into:
  1- Data Layer: Repository implementations and data sources (local DB).
  2- Domain Layer: Business logic, entities, and use cases (the heart of the app).
  3- Presentation Layer: UI components, widgets, and Cubits for state management. 

## 🏡 Getting Started

### Prerequisites
Before you begin, ensure you have the following installed:
- **Flutter SDK**: To build and run your Flutter applications.
- **Dart SDK**: Included with Flutter, used for programming.
- **Android Studio** or **VS Code**: Recommended IDEs for Flutter development.


## 🛠️ Installation

Follow these steps to set up the project locally:

1. **Clone the Repository**
   ```bash
   git clone https://github.com/MG-B17/Meal-Planner
2. Install Dependencies Run the following command to install all necessary Flutter dependencies:
   ```bash
   flutter pub get
3. Run the App Launch the application using:
   ```bash
