final post = {
  'title': 'hello title',
  'detail': 'hello detail',
  'postId': 'post1',
  'userId': 'user1',
  'imageId': 'imageId',
  'imageUrl': 'li.jpg',
  'like':{
    'likes': 20,
    'usernames': ['ram', 'shyam']
  },
  'comments': [
    {
      'username':'ram',
      'comment': 'nice post',
      'image': 'user.jpg'
    }
  ]
};

class Like{
  final int likes;
  final List<String> username;
  Like({
    required this.likes,
    required this.username
});

  factory Like.fromJson(Map<String,dynamic> json){
    return Like(
        likes: json['likes'],
        username: (json['usernames'] as List).map((e) => e as String).toList()
    );
  }
}

class Comment{
  final String username;
  final String comment;
  final String image;

  Comment({
    required this.username,
    required this.image,
    required this.comment
});

  factory Comment.fromJson(Map<String,dynamic> json){
    return Comment(
        username: json['username'],
        image: json['image'],
        comment: json['comment']
    );
  }

  Map toMap (){
    return {
      'username' : this.username,
      'image': this.image,
      'comment':this.comment
    };
  }

}


class Post{

  final String title;
  final String detail;
  final String postId;
  final String imageId;
  final String userId;
  final String imageUrl;
  final Like like;
  final List<Comment> comments;

  Post({
    required this.title,
    required this.detail,
    required this.imageUrl,
    required this.postId,
    required this.userId,
    required this.imageId,
    required this.like,
    required this.comments
});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
        title: json['title'],
        detail: json['detail'],
        imageUrl: json['imageUrl'],
        postId: json['postId'],
        imageId: json['imageId'],
        userId: json['userId'],
        like: Like.fromJson(json['like']),
        comments: (json['comments'] as List).map((e) => Comment.fromJson(e)).toList()
    );
  }


}