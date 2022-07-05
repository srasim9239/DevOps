# Домашнее задание к занятию "7.5. Основы golang"

С `golang` в рамках курса, мы будем работать не много, поэтому можно использовать любой IDE. 
Но рекомендуем ознакомиться с [GoLand](https://www.jetbrains.com/ru-ru/go/).  

## Задача 1. Установите golang.
1. Воспользуйтесь инструкций с официального сайта: [https://golang.org/](https://golang.org/).
2. Так же для тестирования кода можно использовать песочницу: [https://play.golang.org/](https://play.golang.org/).
## Ответ
```
 ras@ras-VirtualBox  ~/DevOps/07-terraform-05-golang   main ±  go version
go version go1.13.8 linux/amd64
```

## Задача 3. Написание кода. 
Цель этого задания закрепить знания о базовом синтаксисе языка. Можно использовать редактор кода 
на своем компьютере, либо использовать песочницу: [https://play.golang.org/](https://play.golang.org/).

1. Напишите программу для перевода метров в футы (1 фут = 0.3048 метр). Можно запросить исходные данные 
у пользователя, а можно статически задать в коде.
    Для взаимодействия с пользователем можно использовать функцию `Scanf`:
    ```
    package main
    
    import "fmt"
    
    func main() {
        fmt.Print("Enter a number: ")
        var input float64
        fmt.Scanf("%f", &input)
    
        output := input * 2
    
        fmt.Println(output)    
    }
    ```
```
 ras@ras-VirtualBox  ~/DevOps/07-terraform-05-golang   main ±  go run 1.go
Type foot: 99
Meters: 30.1752
```
1. Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:
    ```
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    ```
```
package main
  import "fmt"
  func main() {
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,3}
    a := 0
    for i, b := range x {
      if (i == 0) {
        a = b
      } else {
        if (a > b) {
          a = b
        }
      }
      }
    fmt.Println("Min integer: ", a)
  }

 ras@ras-VirtualBox  ~/DevOps/07-terraform-05-golang   main ±  go run 2.go
Min integer:  9
1. Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть `(3, 6, 9, …)`.

В виде решения ссылку на код или сам код. 
```
 package main
  import "fmt"
   func main() {
    for i := 1; i <= 100; i++ {
      if (i%3) == 0 {
        fmt.Print(" ",i,",")
      }
    }
  }

 ras@ras-VirtualBox  ~/DevOps/07-terraform-05-golang   main ±  go run 3.go
 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99,
```
