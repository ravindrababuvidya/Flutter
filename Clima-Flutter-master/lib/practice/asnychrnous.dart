import 'dart:io';
void main(){
  performTasks();
}

void performTasks() async{
  task1();
  print(task2());
  String output =await task2() ;
  task3(output);
}
void task1(){
  print("Task 1 completed");
}
Future<String> task2() async {
  Duration fiveSeconds = Duration(seconds: 5);
  //sleep(fiveSeconds);
  String result ;
  await Future.delayed(fiveSeconds,(){
    result ="Task 2";
    print("Task 2 completed");
  });
  return result;
}

void task3(String input){
  print("Task 3 completed $input");
}
