

class TodoEntry{
  int? id;
  String title;
  String description;
  int done;

  TodoEntry({this.id,required this.title, required this.description, required this.done });
  Map<String, dynamic>toMap (){
    return {
      'id': id,
      'title':title,
      'description': description,
      'done': done,
    };
  }
  factory TodoEntry.fromMap(Map<String, dynamic> json) {
    return TodoEntry(
    id : json['id'],
    title: json['title'],
    description: json['description'],
    done: json['done'],
    );
    }

}