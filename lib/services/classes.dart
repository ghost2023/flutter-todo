class Todo {
  String name = '';
  String status = 'todo';

  Todo(this.name);
  Todo.fromFull(this.name, this.status);

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo.fromFull(
      json['name'] as String,
      json['status'] as String,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
    };
