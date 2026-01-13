// import '../network/dio_client.dart';
// import '../model/task.dart';

// class TaskService {
//   final DioClient dioClient;

//   TaskService(this.dioClient);

//   Future<List<Task>> fetchTasks() async {
//     final response = await dioClient.dio.get('/todos');
//     final List data = response.data;
//     return data.map((e) => Task.fromJson(e)).toList();
//   }
// }