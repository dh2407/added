// Function to create initial subjects
import 'package:added/app/data/models/models.dart';

List<Subject> createInitialSubjects() {
  return [
    Subject(uname: 'plus', title: 'الجمع +'),
    Subject(uname: 'minus', title: 'الطرح -'),
    Subject(uname: 'multiply', title: 'الضرب ×'),
    Subject(uname: 'divide', title: 'القسمة ÷'),
  ];
}

// Function to create subsubjects for a given subject
List<SubSubject> createSubSubjects(Subject subject) {
  List<SubSubject> subSubjects = [];
  for (int i = 1; i <= 9; i++) {
    subSubjects.add(
      SubSubject(
        uname: '${i}_${subject.uname}',
        title:
            getSubSubjectTitle(i, subject),
        subject: subject,
      ),
    );
  }
  return subSubjects;
}

String getSubSubjectTitle(int i, Subject subject) {
  if (subject.uname == 'minus') {
    return '- $i';
  }
  if (subject.uname == 'divide') {
    return '÷ $i';
  }
  if (subject.uname == 'plus') {
    return '$i +';
  }
  if (subject.uname == 'multiply') {
    return '$i ×';
  }
  return "";
}

// Function to create flashcards for a given subsubject
List<FlashCard> createFlashCards(SubSubject subSubject) {
  List<FlashCard> flashCards = [];
  for (int i = 1; i <= 9; i++) {
    String question;
    String response;

    switch (subSubject.subject.uname) {
      case 'plus':
        question = '${subSubject.uname.split('_')[0]} + $i';
        response = (int.parse(subSubject.uname.split('_')[0]) + i).toString();
        break;
      case 'minus':
        question =
            '${(int.parse(subSubject.uname.split('_')[0]) + i)} - ${subSubject.uname.split('_')[0]}';
        response = (i).toString();
        break;
      case 'multiply':
        question = '${subSubject.uname.split('_')[0]} × $i';
        response = (int.parse(subSubject.uname.split('_')[0]) * i).toString();
        break;
      case 'divide':
        question =
            '${(int.parse(subSubject.uname.split('_')[0]) * i)} ÷ ${subSubject.uname.split('_')[0]}';
        response = (i).toString();
        break;
      default:
        question = '';
        response = '';
    }

    flashCards.add(
      FlashCard(
        uname: '${subSubject.uname}_$i',
        subSubject: subSubject,
        question: question,
        response: response,
      ),
    );
  }
  return flashCards;
}

void main() {
  // Example usage:
  List<Subject> subjects = createInitialSubjects();

  for (Subject subject in subjects) {
    List<SubSubject> subSubjects = createSubSubjects(subject);

    for (SubSubject subSubject in subSubjects) {
      List<FlashCard> flashCards = createFlashCards(subSubject);

      // Print flashcards for demonstration purposes
      for (FlashCard flashCard in flashCards) {
        print(
            'FlashCard Uname: ${flashCard.uname}, Question: ${flashCard.question}, Response: ${flashCard.response}');
      }
    }
  }
}
