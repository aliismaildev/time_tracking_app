import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracking_app/consts/enums.dart';
import 'package:time_tracking_app/consts/lang.dart';
import 'package:time_tracking_app/consts/strings_of_enums.dart';
import 'package:time_tracking_app/core/models/task_datamodel.dart';
import 'package:time_tracking_app/core/viewmodels/home_viewmodel.dart';
import 'package:time_tracking_app/utils/percentage_size_ext.dart';
import 'package:time_tracking_app/views/base_views/base_views.dart';
import 'package:time_tracking_app/views/widgets/text.dart';
import 'package:time_tracking_app/views/widgets/text_fields.dart';
import 'package:time_tracking_app/views/widgets/toast.dart';

class HomeView extends StatefulWidget {
  final double tileHeight = 100;
  final double headerHeight = 80;
  final double tileWidth = 300;
  static const String routeName = '/homeView';

  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LinkedHashMap<String, List<TaskDataModel>>? board;

  @override
  void initState() {
    board = LinkedHashMap();
    board!.addAll({
      TaskStatus.toDo.toString(): [
        TaskDataModel(
            taskId: '51262',
            taskStatus: TaskStatus.toDo.toString(),
            taskDescription: "Task 1"),
        TaskDataModel(
            taskId: '51262',
            taskStatus: TaskStatus.toDo.toString(),
            taskDescription: "Task 2"),
      ],
      TaskStatus.inProgress.toString(): [
        TaskDataModel(
            taskId: '51262',
            taskStatus: TaskStatus.inProgress.toString(),
            taskDescription: "Task 3"),
        TaskDataModel(
            taskId: '51262',
            taskStatus: TaskStatus.inProgress.toString(),
            taskDescription: "Task 4"),
      ],
      TaskStatus.done.toString(): [
        TaskDataModel(
            taskId: '51262',
            taskStatus: TaskStatus.done.toString(),
            taskDescription: "Task 5"),
        TaskDataModel(
            taskId: '51262',
            taskStatus: TaskStatus.done.toString(),
            taskDescription: "Task 6"),
      ]
    });

    super.initState();
  }

  buildItemDragTarget(listId, targetPosition, double height) {
    return DragTarget<TaskDataModel>(
      // Will accept others, but not himself
      onWillAccept: (TaskDataModel? data) {
        return board![listId]!.isEmpty ||
            data!.taskId != board![listId]![targetPosition].taskId;
      },
      // Moves the card into the position
      onAccept: (TaskDataModel data) {
        setState(() {
          board![data.taskStatus]!.remove(data);
          data.taskStatus = listId;
          if (board![listId]!.length > targetPosition) {
            board![listId]!.insert(targetPosition + 1, data);
          } else {
            board![listId]!.add(data);
          }
        });
      },
      builder: (BuildContext context, List<TaskDataModel?> data,
          List<dynamic> rejectedData) {
        if (data.isEmpty) {
          // The area that accepts the draggable
          return Container(
            height: height,
          );
        } else {
          return Column(
            // What's shown when hovering on it
            children: [
              Container(
                height: height,
              ),
              ...data.map((TaskDataModel? item) {
                return Opacity(
                  opacity: 0.5,
                  child: ItemWidget(item: item),
                );
              }).toList()
            ],
          );
        }
      },
    );
  }

  buildHeader(
      {required String listId,
      required HomeViewModel read,
      required HomeViewModel watch}) {
    Widget header = SizedBox(
      height: widget.headerHeight,
      child: HeaderWidget(
        title: listId,
        watch: watch,
        read: read,
      ),
    );

    return Stack(
      // The header
      children: [
        Draggable<String>(
          data: listId, // A header waiting to be dragged
          childWhenDragging: Opacity(
            // The header that's left behind
            opacity: 0.2,
            child: header,
          ),
          feedback: FloatingWidget(
            child: SizedBox(
              // A header floating around
              width: widget.tileWidth,
              child: header,
            ),
          ),
          child: header,
        ),
        buildItemDragTarget(listId, 0, widget.headerHeight),
        DragTarget<String>(
          // Will accept others, but not himself
          onWillAccept: (String? incomingListId) {
            return listId != incomingListId;
          },
          // Moves the card into the position
          onAccept: (String incomingListId) {
            setState(
              () {
                LinkedHashMap<String, List<TaskDataModel>> reorderedBoard =
                    LinkedHashMap();
                for (String key in board!.keys) {
                  if (key == incomingListId) {
                    reorderedBoard[listId] = board![listId]!;
                  } else if (key == listId) {
                    reorderedBoard[incomingListId] = board![incomingListId]!;
                  } else {
                    reorderedBoard[key] = board![key]!;
                  }
                }
                board = reorderedBoard;
              },
            );
          },

          builder: (BuildContext context, List<String?> data,
              List<dynamic> rejectedData) {
            if (data.isEmpty) {
              // The area that accepts the draggable
              return SizedBox(
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Colors.blueAccent,
                  ),
                ),
                height: widget.headerHeight,
                width: widget.tileWidth,
              );
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final read = context.read<HomeViewModel>();
    final watch = context.watch<HomeViewModel>();
    buildHomeViewList(String listId, List<TaskDataModel> items) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: context.screenHeight,
          child: Column(
            children: [
              buildHeader(listId: listId, read: read, watch: watch),
              StreamBuilder(
                  stream: read.getAllTasks().onValue,
                  builder: (context, snapshot) {
                    List<TaskDataModel> tasksList = [];
                    if (snapshot.hasError) {
                      return Text("Errorz");
                    }
                    if (snapshot.connectionState == ConnectionState.active) {
                      final data = Map<String, dynamic>.from(
                          snapshot.data!.snapshot.value as Map);

                      data.forEach((key, value) {
                        final result = Map<String, dynamic>.from(value);
                        TaskDataModel model = TaskDataModel.fromJson(result);
                        tasksList.add(model);
                      });
                    }
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            Draggable<TaskDataModel>(
                              data: items[index],
                              // A card waiting to be dragged
                              childWhenDragging: Opacity(
                                // The card that's left behind
                                opacity: 0.2,
                                child: ItemWidget(item: items[index]),
                              ),
                              feedback: SizedBox(
                                // A card floating around
                                height: widget.tileHeight,
                                width: widget.tileWidth,
                                child: FloatingWidget(
                                    child: ItemWidget(
                                  item: items[index],
                                )),
                              ),
                              child: ItemWidget(
                                item: items[index],
                              ),
                            ),
                            buildItemDragTarget(
                                listId, index, widget.tileHeight),
                          ],
                        );
                      },
                    );
                  })
            ],
          ),
        ),
      );
    }

    return BaseScaffold(
        scrollDirection: Axis.horizontal,
        showAppBar: true,
        body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: board!.keys.map((String key) {
              return SizedBox(
                width: widget.tileWidth,
                child: buildHomeViewList(key, board![key]!),
              );
            }).toList()));
  }
}

// The list header (static)
class HeaderWidget extends StatelessWidget {
  final String? title;
  final HomeViewModel? read;
  final HomeViewModel? watch;

  const HeaderWidget({Key? key, this.title, this.read, this.watch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.teal,
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          title: Text(
            taskStatusString(title),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30.0,
          ),
          onTap: () => _addTask(
              context: context, title: title!, read: read!, watch: watch!),
        ));
  }
}

//add task

void _addTask(
    {required BuildContext context,
    required String title,
    required HomeViewModel read,
    required HomeViewModel watch}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        title: headline3("${Lang.add} ${Lang.task}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTxtField(
              hintTxt: Lang.task,
              textEditingController: read.addTaskController,
              validator: (String? val) {
                if (val!.isEmpty) {
                  return Lang.task;
                }
                return null;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text(Lang.cancel),
            onPressed: () => Navigator.pop(context),
          ),
          watch.viewState == ViewState.busy
              ? const CircularProgressIndicator()
              : TextButton(
                  child: const Text(Lang.save),
                  onPressed: () async {
                    if (read.addTaskController.text.isNotEmpty) {
                      final result = await read.addTask(title);
                      if (result.isSuccess) {
                        if (context.mounted) Navigator.pop(context);
                        showToast(msg: Lang.taskAddedSuccessfully);
                      } else {
                        showToast(msg: Lang.pleaseTryAgainLater);
                      }
                    } else {
                      showToast(msg: Lang.allFieldsAreRequired);
                    }
                  })
        ],
      );
    },
  );
}

// The card (static)
class ItemWidget extends StatelessWidget {
  final TaskDataModel? item;

  const ItemWidget({Key? key, this.item}) : super(key: key);

  ListTile makeListTile(TaskDataModel item) => ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          item.taskDescription!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text("listId: ${taskStatusString(item.taskDescription)}"),
        trailing: const Icon(
          Icons.sort,
          color: Colors.white,
          size: 30.0,
        ),
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(64, 75, 96, .9),
        ),
        child: makeListTile(item!),
      ),
    );
  }
}

class FloatingWidget extends StatelessWidget {
  final Widget? child;

  const FloatingWidget({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child!;
  }
}
