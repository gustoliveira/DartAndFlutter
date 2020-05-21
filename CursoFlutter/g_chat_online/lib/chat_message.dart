import 'package:flutter/material.dart';

class ChatMessage extends StatefulWidget {
  ChatMessage(this.data, this.mine);

  final Map<String, dynamic> data;
  final bool mine;

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        return showDialog(context: context,
          builder: (context){
            return AlertDialog(
              content: Text("Horário: ${widget.data["date"]}"),
            );
          }
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: <Widget>[
            !widget.mine ? Padding(
                padding: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.data["senderPhotoURL"]),
                ),
              ) : Container(),
            Expanded(
              child: Column(
                crossAxisAlignment: widget.mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  widget.data["imageUrl"] != null ?
                    Image.network(widget.data["imageUrl"], width: 250) :
                    Text(
                      widget.data["text"],
                      style: TextStyle(fontSize: 18),
                      textAlign: widget.mine ? TextAlign.end : TextAlign.start,
                    ),
                  Text(
                    widget.data["senderName"],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic
                    ),
                  )
                ],
              ),
            ),
            widget.mine ? Padding(
                padding: EdgeInsets.only(left: 16),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.data["senderPhotoURL"]),
                ),
              ) : Container(),
          ],
        ),
      ),
    );
  }
}