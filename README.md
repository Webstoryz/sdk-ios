# WebstoryzPackage

### Установка
На текущий момент возможна только via Swift Package Manager 
В Xcode в разделе "Project" в сегменте "Package Dependencies" укажите ссылку на этот репозиторий (https://github.com/Webstoryz/sdk-ios) и укажите удовлетворяющую версию (на текущий момент лучше всего exact 1.0.17) 

### Использование
На текущий момент возможно вызывать элемент, содержащий ярлыки историй и направляющий на воспроизведение, через SwiftUI и UIViewController.
В первом случае необходимо вызвать элемент с помощью импортирования пакета и вызова статической функции 
```swift
import WebstoryzPackage
...
var body: some View {
  SDK.thumbs(key: "ваш ключ к апи", onLoadFailed: {
    функция, вызывающаяся, если что-то пойдет не так
  })
}
```
Во втором случае в SDK предоставляется функция 
```swift 
  SDK.thumbs(key: "ваш ключ к апи",uiController: *Родительский UIViewController*, onLoadFailed: {
    функция, вызывающаяся, если что-то пойдет не так
  })

```

В sdk используются внутренние функциональные элементы, которые можно задавать в конструкторе
```swift
struct TextStyle {
  var color: Color
  var weight: Font.Weight
  var size: CGFloat
  var lineLimit: Int
}
```
Эта структура отвечает за стилистику текста в элементе, содержащем ярлыки. В кострукторе по умолчанию указаны следующие параметры 
```swift 
  color: Color = Color.black, weight: Font.Weight = .medium, size: CGFloat = 16, lineLimit: Int = 2
```

```swift
enum CaptionType {
  case outside
  case inside
  case none
}
```
Это перечисление определяет, как будет отображаться подпись каждого из ярлыков элемента — соответственно снаружи ярлыка(снизу), внутри ярлыка(у нижней границы) или же не будет отображена


Помимо вышеперечисленных необходимых параметров, в этих функциях опционально можно указывать следующие параметры: 
```swift
    headerStyle: TextStyle = TextStyle(),
    showHeader: Bool = true,
```
Эти параметры отвечают за отображение заглавия элемента, содержащего ярлыки. headerStyle за стиль отображения, showHeader за то, будет ли заглавие отображено. 

```swift
  captionStyle: TextStyle = TextStyle(),
  captionType: CaptionType = CaptionType.outside
```
Эти параметры отвечают за отображение подписи к ярлыкам внутри элемента. captionStyle за стиль отображения, captionType за то, как подпись будет расположена

```swift
  leadingPadding: Int = 0
```
Параметр отвечает за то, какое расстояние будет между ярлыками и краем виджета с левой стороны 

```swift
  backgroundColor: Color = Color.white
```
Параметр отвечает за то, какой цвет будет отображен сзади виджета
