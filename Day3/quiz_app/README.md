# Quiz App 🎯

Një aplikacion quiz me shumë ekrane i ndërtuar me Flutter.

## Përshkrimi

Ky aplikacion quiz përfshin pyetje me 4 opsione, menaxhim të pikëve me state, dhe navigim me Navigator midis ekraneve.

## Karakteristikat

- ✅ **7 pyetje** me 4 opsione secila
- ✅ **State management** me `setState` për pikët dhe pyetjen aktuale
- ✅ **Navigator** për tranzicion midis ekranit të quiz-it dhe rezultatit
- ✅ **Ekran final** me rezultat të detajuar dhe buton restart
- ✅ **Animacione** — fade transitions, animated progress bar, counting animation
- ✅ **UI responsive** — adaptohet për mobile dhe desktop
- ✅ **Glassmorphism design** — efekte moderne me gradient dhe transparencë

## Struktura e Projektit

```
lib/
├── main.dart                  # Pika hyrëse e aplikacionit
├── models/
│   └── question.dart          # Modeli i pyetjes
├── data/
│   └── quiz_data.dart         # Lista e pyetjeve
└── screens/
    ├── quiz_screen.dart       # Ekrani kryesor i quiz-it
    └── result_screen.dart     # Ekrani i rezultatit
```

## Si të ekzekutohet

```bash
flutter pub get
flutter run
```

## Screenshot-e

| Ekrani i Quiz-it | Ekrani i Rezultatit |
|:-:|:-:|
| Pyetja me opsione | Rezultati me statistika |

## Konceptet e përdorura

| Koncept | Implementimi |
|---------|-------------|
| `StatefulWidget` | QuizScreen, ResultScreen |
| `setState()` | Ndryshimi i pyetjes, pikëve, opsionit |
| `Navigator.pushReplacement` | Kalimi midis ekraneve |
| `AnimationController` | Fade & scale tranzicione |
| `TweenAnimationBuilder` | Progress bar i animuar |

---

*Internship Day 3 — Task 1: Multi-screen Quiz App*
