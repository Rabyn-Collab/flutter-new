



class Video{

final String  name;
 final String key;

 Video({required this.name, required this.key});

 factory Video.fromJson(Map<String, dynamic> json){
   return Video(
       name: json['name'],
       key: json['key']
   );
 }

}