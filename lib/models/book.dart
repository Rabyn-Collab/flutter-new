



class Book{
  final String imageUrl;
  final String title;
  final String detail;
  final String rating;
  final String genre;
  
  Book({
    required this.title,
    required this.detail,
    required this.genre,
    required this.imageUrl,
    required this.rating
});
  
  
}


List<Book> books = [
  Book(
      title: 'To Kill a Mockingbird1',
      detail: 'To Kill a Mockingbird is a novel by the American author Harper Lee. It was published in 1960 and was instantly successful. In the United States, it is widely read in high schools and middle schools. To Kill a Mockingbird has become a classic of modern American literature',
      genre: 'horror',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg/800px-To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg',
      rating: '⭐⭐⭐⭐⭐'
  ),
  Book(
      title: 'To Kill a Mockingbird2',
      detail: 'To Kill a Mockingbird is a novel by the American author Harper Lee. It was published in 1960 and was instantly successful. In the United States, it is widely read in high schools and middle schools. To Kill a Mockingbird has become a classic of modern American literature',
      genre: 'horror',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg/800px-To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg',
      rating: '⭐⭐⭐⭐⭐'
  ),
  Book(
      title: 'To Kill a Mockingbird',
      detail: 'To Kill a Mockingbird is a novel by the American author Harper Lee. It was published in 1960 and was instantly successful. In the United States, it is widely read in high schools and middle schools. To Kill a Mockingbird has become a classic of modern American literature',
      genre: 'horror',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg/800px-To_Kill_a_Mockingbird_%28first_edition_cover%29.jpg',
      rating: '⭐⭐⭐⭐⭐'
  ),
];