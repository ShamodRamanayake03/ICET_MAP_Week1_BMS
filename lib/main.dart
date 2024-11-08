import 'dart:collection';

// Enum for Book Status
enum BookStatus { available, borrowed }

// Base Class: Book
class Book {
  String title;
  String author;
  String isbn;
  BookStatus status;

  Book({
    required this.title,
    required this.author,
    required this.isbn,
    this.status = BookStatus.available,
  }) {
    if (!isValidISBN(isbn)) {
      throw ArgumentError('Invalid ISBN number');
    }
  }

  // ISBN Validation method
  bool isValidISBN(String isbn) {
    return RegExp(r'^\d{3}-\d{10}$').hasMatch(isbn);
  }

  // Status update method
  void updateStatus(BookStatus newStatus) {
    status = newStatus;
  }

  // Getters and Setters
  String get getTitle => title;
  set setTitle(String title) => this.title = title;

  String get getAuthor => author;
  set setAuthor(String author) => this.author = author;

  String get getISBN => isbn;
  set setISBN(String isbn) {
    if (isValidISBN(isbn)) {
      this.isbn = isbn;
    } else {
      throw ArgumentError('Invalid ISBN number');
    }
  }

  BookStatus get getStatus => status;
  set setStatus(BookStatus status) => this.status = status;
}

// Derived Class: TextBook
class TextBook extends Book {
  String subjectArea;
  int gradeLevel;

  TextBook({
    required String title,
    required String author,
    required String isbn,
    required this.subjectArea,
    required this.gradeLevel,
    BookStatus status = BookStatus.available,
  }) : super(title: title, author: author, isbn: isbn, status: status);

  // Getters and Setters for new properties
  String get getSubjectArea => subjectArea;
  set setSubjectArea(String subjectArea) => this.subjectArea = subjectArea;

  int get getGradeLevel => gradeLevel;
  set setGradeLevel(int gradeLevel) => this.gradeLevel = gradeLevel;
}

// Book Management System
class BookManagementSystem {
  final List<Book> _books = [];

  // Method to add a new book to collection
  void addBook(Book book) {
    _books.add(book);
    print('Book added: ${book.title}');
  }

  // Method to remove a book from collection
  bool removeBook(String isbn) {
    int initialCount = _books.length;
    _books.removeWhere((book) => book.isbn == isbn);
    return _books.length < initialCount;
  }

  // Method to update book status
  bool updateBookStatus(String isbn, BookStatus status) {
    for (var book in _books) {
      if (book.isbn == isbn) {
        book.updateStatus(status);
        print('Status updated for ISBN $isbn to $status');
        return true;
      }
    }
    print('Book not found with ISBN $isbn');
    return false;
  }

  // Search by title
  List<Book> searchByTitle(String title) {
    return _books.where((book) => book.title.contains(title)).toList();
  }

  // Search by author
  List<Book> searchByAuthor(String author) {
    return _books.where((book) => book.author.contains(author)).toList();
  }

  // Basic filtering (available or borrowed books)
  List<Book> filterByStatus(BookStatus status) {
    return _books.where((book) => book.status == status).toList();
  }

  // Display all books (for testing purposes)
  void displayBooks() {
    if (_books.isEmpty) {
      print('No books available.');
      return;
    }
    for (var book in _books) {
      print(
          'Title: ${book.title}, Author: ${book.author}, ISBN: ${book.isbn}, Status: ${book.status}');
    }
  }
}

void main() {
  // Creating instances of BookManagementSystem and TextBook
  var library = BookManagementSystem();
  var book1 = Book(title: 'Dart Programming', author: 'Author A', isbn: '123-1234567890');
  var textbook1 = TextBook(
      title: 'Math for Grade 10',
      author: 'Author B',
      isbn: '124-1234567890',
      subjectArea: 'Mathematics',
      gradeLevel: 10);

  // Adding books
  library.addBook(book1);
  library.addBook(textbook1);

  // Display all books
  library.displayBooks();

  // Update status of a book
  library.updateBookStatus('123-1234567890', BookStatus.borrowed);

  // Search by title
  print('\nSearch by title "Dart":');
  var searchResults = library.searchByTitle('Dart');
  searchResults.forEach((book) => print(book.title));

  // Filter by status (Available)
  print('\nBooks available:');
  var availableBooks = library.filterByStatus(BookStatus.available);
  availableBooks.forEach((book) => print(book.title));
}
