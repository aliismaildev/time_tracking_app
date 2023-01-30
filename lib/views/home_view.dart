import 'dart:collection';

import 'package:flutter/material.dart';

class Item {
  final String? id;
  String? listId;
  final String? title;

  Item({this.id, this.listId, this.title});
}

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
  LinkedHashMap<String, List<Item>>? board;

  @override
  void initState() {
    board = LinkedHashMap();
    board!.addAll({
      "1": [
        Item(id: "1", listId: "1", title: "Pera"),
        Item(id: "2", listId: "1", title: "Papa"),
      ],
      "2": [
        Item(id: "3", listId: "2", title: "Auto"),
        Item(id: "4", listId: "2", title: "Bicicleta"),
        Item(id: "5", listId: "2", title: "Bla bla"),
      ],
      "3": [
        Item(id: "6", listId: "3", title: "Chile"),
        Item(id: "7", listId: "3", title: "Madagascar"),
        Item(id: "8", listId: "3", title: "Japón"),
      ]
    });

    super.initState();
  }

  buildItemDragTarget(listId, targetPosition, double height) {
    return DragTarget<Item>(
      // Will accept others, but not himself
      onWillAccept: (Item? data) {
        return board![listId]!.isEmpty || data!.id != board![listId]![targetPosition].id;
      },
      // Moves the card into the position
      onAccept: (Item data) {
        setState(() {
          board![data.listId]!.remove(data);
          data.listId = listId;
          if (board![listId]!.length > targetPosition) {
            board![listId]!.insert(targetPosition + 1, data);
          } else {
            board![listId]!.add(data);
          }
        });
      },
      builder: (BuildContext context, List<Item?> data, List<dynamic> rejectedData) {
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
              ...data.map((Item? item) {
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

  buildHeader(String listId) {
    Widget header = SizedBox(
      height: widget.headerHeight,
      child: HeaderWidget(title: listId),
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
                LinkedHashMap<String, List<Item>> reorderedBoard = LinkedHashMap();
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

          builder: (BuildContext context, List<String?> data, List<dynamic> rejectedData) {
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
    buildHomeViewList(String listId, List<Item> items) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            buildHeader(listId),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                // A stack that provides:
                // * A draggable object
                // * An area for incoming draggables
                return Stack(
                  children: [
                    Draggable<Item>(
                      data: items[index], // A card waiting to be dragged
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
                    buildItemDragTarget(listId, index, widget.tileHeight),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(title: const Text("HomeView test")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: board!.keys.map((String key) {
              return SizedBox(
                width: widget.tileWidth,
                child: buildHomeViewList(key, board![key]!),
              );
            }).toList()),
      ),
    );
  }
}

// The list header (static)
class HeaderWidget extends StatelessWidget {
  final String? title;

  const HeaderWidget({Key? key, this.title}) : super(key: key);

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
          title!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.sort,
          color: Colors.white,
          size: 30.0,
        ),
        onTap: () {},
      ),
    );
  }
}

// The card (static)
class ItemWidget extends StatelessWidget {
  final Item? item;

  const ItemWidget({Key? key, this.item}) : super(key: key);

  ListTile makeListTile(Item item) => ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        title: Text(
          item.title!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Text("listId: ${item.listId}"),
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
