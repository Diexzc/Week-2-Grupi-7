# Registration Form 📝

Një formë regjistrimi me validim dhe feedback vizual e ndërtuar me Flutter.

## Përshkrimi

Ky aplikacion përfshin formën e regjistrimit me validim të email-it, fjalëkalimit, dhe shfaqje të mesazheve të gabimit inline pa e prishur layout-in.

## Karakteristikat

- ✅ **Fushat**: Emër, Email, Fjalëkalim, Konfirmim fjalëkalimi, Rol/Status
- ✅ **Validim email-i** me RegExp pattern
- ✅ **Validim fjalëkalimi** — minimumi 8 karaktere, shkronjë e madhe, numër
- ✅ **Indikator i forcës** së fjalëkalimit (e dobët → shumë e fortë)
- ✅ **Mesazhe gabimi inline** pa e prishur layout-in
- ✅ **Summary screen** pas regjistrimit të suksesshëm
- ✅ **Loading state** gjatë dërgimit
- ✅ **UI responsive** — adaptohet për mobile dhe desktop
- ✅ **Animacione** — fade transitions, elastic scale, animated strength bar

## Struktura e Projektit

```
lib/
├── main.dart                        # Pika hyrëse e aplikacionit
├── models/
│   └── registration_data.dart       # Modeli i të dhënave
├── utils/
│   └── form_validators.dart         # Funksionet e validimit
└── screens/
    ├── registration_screen.dart     # Forma e regjistrimit
    └── summary_screen.dart          # Ekrani i përfundimit
```

## Si të ekzekutohet

```bash
flutter create .
flutter pub get
flutter run
```

## Konceptet e përdorura

| Koncept | Implementimi |
|---------|-------------|
| `Form` + `GlobalKey<FormState>` | Validimi i formës |
| `TextFormField` | Fushat me validim |
| `TextEditingController` | Menaxhimi i tekstit |
| `DropdownButtonFormField` | Zgjedhja e rolit |
| `Navigator.push / pop` | Navigimi midis ekraneve |
| `AutovalidateMode` | Validim automatik pas tentativës |
| `RegExp` | Validimi i email-it |
| `AnimatedContainer` | Indikatori i forcës |

## Validimi

| Fusha | Rregullat |
|-------|-----------|
| Emri | ≥ 2 karaktere |
| Email | Format i vlefshëm (regex) |
| Fjalëkalimi | ≥ 8 karaktere, 1 shkronjë e madhe, 1 numër |
| Konfirmimi | Duhet të përputhet me fjalëkalimin |
| Roli | Duhet të zgjedhet |

---

*Internship Day 2 — Task 2: Registration Form*
