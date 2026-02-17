# Food Delivery Menu App: UIKit & SwiftUI Implementation

### 📋 Описание проекта

Приложение для отображения меню доставки еды, разработанное с упором на строгое соответствие дизайн-требованиям и эффективную работу с сетевыми данными. Основная задача — показать гибкость архитектуры при использовании двух разных UI-фреймворков (UIKit и SwiftUI) с общим бэкенд-слоем (имитация через JSON).

### 🛠 Что реализовано

#### 1. Соответствие дизайну (Design Fidelity)

* **Динамические ячейки**: Верстка адаптируется под разную длину описания блюда. Если описание слишком длинное, оно ограничивается 3 строками (`lineLimit`), сохраняя целостность списка.
* **Обработка отсутствующих данных**: Если у блюда нет заголовка или картинки, интерфейс не «ломается». В UIKit использованы `UIStackView` для автоматического схлопывания пустых пространств, в SwiftUI — условная отрисовка.
* **Визуальный отклик**: Добавлены плейсхолдеры (скелетоны) серого цвета (`systemGray6`), которые отображаются до полной загрузки изображений.

#### 2. Работа с данными (Data & Networking)

* **JSON Parsing**: Реализована подгрузка данных из JSON-файлов через `JSONDecoder` с использованием стратегии `convertFromSnakeCase`.
* **Image Loading**:
* В **UIKit** реализована кастомная асинхронная загрузка через `URLSessionDataTask` с механизмом отмены задачи (`cancel`) при переиспользовании ячейки, что предотвращает баги с отображением неверных картинок.
* В **SwiftUI** применен нативный `AsyncImage` с обработкой фаз загрузки.


* **Memory Management**: Использование `[weak self]` в замыканиях для предотвращения утечек памяти (Retain Cycles).

#### 3. Технологический стек

* **UIKit**:
* Программная верстка без Storyboards (Pure Code).
* `UITableView` с динамической высотой ячеек.
* Анимация появления элементов списка через `alpha` и `UIView.animate`.
* Интеграция `UIRefreshControl` (Pull-to-Refresh).


* **SwiftUI & Combine**:
* Реактивный подход с использованием `@StateObject` и `@Published`.
* Обработка потоков данных через `Combine` (операторы `decode`, `receive(on:)`, `sink`).
* Декларативная верстка с использованием `List`, `VStack`, `HStack`.

---

### 📂 Структура проекта

* `ViewController.swift` — точка входа для UIKit версии.
* `MainView.swift` — главный экран на SwiftUI.
* `ContentService` / `ContentServiceCombine` — логика получения и парсинга данных.
* `ContentItem.swift` — универсальная модель данных, поддерживающая `Decodable` и `Identifiable`.

---

### 🚀 Как запустить

Приложение поддерживает автоматическое переключение между UIKit и SwiftUI версиями через флаги компиляции в `AppDelegate`. Для запуска SwiftUI версии достаточно установить **Deployment Target 15.0+** и запустить проект на симуляторе.


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


# Food Delivery Menu App (Dual Implementation: UIKit & SwiftUI)

### 📋 Project Overview

This application is a food delivery menu viewer built to demonstrate a high level of fidelity to design requirements and efficient data handling. The project features a dual UI implementation, showcasing the ability to build robust interfaces using both **UIKit** (Imperative) and **SwiftUI** (Declarative) while sharing a common data layer.

### 🛠 Key Features & Implementation Details

#### 1. Design Fidelity & UI Logic

* **Dynamic Cell Sizing**: Layouts automatically adjust to varying content lengths. Descriptions are capped at 3 lines using `lineLimit` to maintain visual consistency across the list.
* **Graceful Handling of Missing Data**: The UI remains intact even if titles or images are missing.
* In **UIKit**, `UIStackView` is utilized to collapse empty spaces automatically.
* In **SwiftUI**, conditional rendering ensures a clean layout.


* **Visual Feedback**: Gray placeholders (`systemGray6`) serve as "skeletons" during image loading to improve perceived performance.

#### 2. Data Management & Networking

* **JSON Parsing**: Data is fetched from local/simulated JSON files using `JSONDecoder` with a `convertFromSnakeCase` key decoding strategy.
* **Asynchronous Image Loading**:
* **UIKit**: Implemented a custom asynchronous loader using `URLSessionDataTask` with a task cancellation mechanism in `prepareForReuse` to prevent "flickering" or incorrect images during fast scrolling.
* **SwiftUI**: Utilizes the native `AsyncImage` component with phase handling for loading and error states.


* **Memory Management**: Strict use of `[weak self]` in closures to prevent retain cycles and memory leaks.

#### 3. Technical Stack

* **UIKit Implementation**:
* **Programmatic UI**: 100% code-based layout (no Storyboards/XIBs).
* **Advanced TableView**: Custom `UITableViewCell` classes with `automaticDimension` for dynamic heights.
* **Animations**: Smooth cell appearance animations using `alpha` transitions and `UIView.animate`.
* **Interaction**: Integrated `UIRefreshControl` for a native Pull-to-Refresh experience.


* **SwiftUI & Combine Implementation**:
* **Reactive Architecture**: State management driven by `@StateObject` and `@Published`.
* **Combine Framework**: Data streams handled via Combine operators (`decode`, `receive(on:)`, `sink`).
* **Modern Components**: Leverages `List`, `VStack`, `HStack`, and the native `.refreshable` modifier.



---

### 📂 Project Structure

* `ViewController.swift` — The entry point and logic for the UIKit implementation.
* `MainView.swift` — The primary interface for the SwiftUI implementation.
* `ContentService` / `ContentServiceCombine` — Service layers handling data fetching and decoding logic.
* `ContentItem.swift` — A unified data model conforming to `Decodable` and `Identifiable`.

---

### 🚀 How to Run

The project supports switching between UIKit and SwiftUI versions via compilation flags in the `AppDelegate`.

1. Open the project in Xcode.
2. Set the **Minimum Deployment Target** to **iOS 15.0** or higher.
3. Select a Simulator (e.g., iPhone 15/16).
4. Press `Cmd + R` to run.

---
