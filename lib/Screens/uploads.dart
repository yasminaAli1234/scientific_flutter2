import 'package:flutter/material.dart';

class UploudFile extends StatelessWidget {
  const UploudFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uploud File" ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.green),),

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.image , color: Colors.green,)),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.video_camera_back_rounded , color: Colors.green,)),
              IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.file_copy_rounded , color: Colors.green,)),
            ],
          ),

        ),
      ),
    );
  }
}
