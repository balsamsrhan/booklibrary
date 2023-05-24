import 'package:booklibrary/models/Helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../Firebase/fb_storge_controller.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  _ImagesScreenState createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> with Helpers {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<StorageBloc>(context).add(ReadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/upload_image_screen'),
            icon: const Icon(
              Icons.cloud_upload,
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Reference>>(
        future: FBStorageFireBase().readAllImage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future:snapshot.data![index].getDownloadURL() ,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                      return Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CachedNetworkImage(imageUrl: snapshot.data!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            cacheKey: snapshot.data,
                          )
                      );
                    }else {
                      return Center(
                        child: Text("no data"),
                      );
                    }
                  },

                );
              },
            );
          } else {
            return Center(
              child: Text("no data"),
            );
          }
        },
      ),
    );
  }

  Future<void> deleteImage({required String filePath}) async {
    // BlocProvider.of<StorageBloc>(context).add(DeleteEvent(filePath));
  }
}