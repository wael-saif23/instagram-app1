import 'package:flutter/material.dart';
import 'package:insta_s_m_app/share/colors.dart';
import 'package:intl/intl.dart';




class UsersPostsContainer extends StatefulWidget {
  const UsersPostsContainer({super.key, required this.data});
    final Map<String, dynamic> data;
  @override
  State<UsersPostsContainer> createState() => _UsersPostsContainerState();
}

class _UsersPostsContainerState extends State<UsersPostsContainer> {
 
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: mobileBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(
          vertical: 11, horizontal: widthScreen > 600 ? widthScreen / 6 : 0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Row(
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 36,
                        backgroundImage: NetworkImage(
                            // widget.snap["profileImg"],
                            // "https://i.pinimg.com/564x/d8/c5/6a/d8c56a664bc9a28d7e32b01a71884af2.jpg"
                            widget.data["profileImg"],
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Text(
                      // widget.snap["username"],
                      widget.data["username"],
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
              ],
            ),
          ),
          Image.network(
            // widget.snap["postUrl"],
            widget.data["imgPost"],
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.comment_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_outline),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              width: double.infinity,
              child:  Text(
                "${widget.data["likes"].length}  ${widget.data["likes"].length >1? "Likes" : "like"} ",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
              )),
           Row(
            children: [
              SizedBox(
                width: 9,
              ),
              Text(
                // "${widget.snap["username"]}",
                widget.data["username"],
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 20, color: Color.fromARGB(255, 189, 196, 199)),
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                // " ${widget.snap["description"]}",
                widget.data["description"],
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 189, 196, 199)),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.fromLTRB(10, 13, 9, 10),
                width: double.infinity,
                child: const Text(
                  "view all 100 comments",
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
                  textAlign: TextAlign.start,
                )),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 9, 10),
              width: double.infinity,
              child:  Text(
                 DateFormat('MMMM ,d,y').format(widget.data["datePublished"].toDate()),
                // widget.data["datePublished"],
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(214, 157, 157, 165)),
                textAlign: TextAlign.start,
              )),
        ],
      ),
    );
  }
}
