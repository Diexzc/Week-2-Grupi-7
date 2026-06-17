import '../models/question.dart';

/// Lista e pyetjeve të quiz-it.
///
/// Çdo pyetje ka 4 opsione dhe një përgjigje të saktë.
const List<Question> quizQuestions = [
  Question(
    questionText: 'Cila është kryeqyteti i Shqipërisë?',
    options: ['Prishtinë', 'Tiranë', 'Shkodër', 'Durrës'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Cili gjuhë programimi përdoret për të ndërtuar aplikacione Flutter?',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Sa është rezultati i 15 × 8?',
    options: ['100', '110', '120', '130'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Cili planet është më i afërt me Diellin?',
    options: ['Venusi', 'Toka', 'Mërkuri', 'Marsi'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Në cilin vit u shpall pavarësia e Kosovës?',
    options: ['2006', '2007', '2008', '2009'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Cili widget në Flutter përdoret për të shfaqur tekst?',
    options: ['Container', 'Text', 'Column', 'Row'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Cila është lumi më i gjatë në Europë?',
    options: ['Danubi', 'Rini', 'Vollga', 'Tamiza'],
    correctAnswerIndex: 2,
  ),
];
