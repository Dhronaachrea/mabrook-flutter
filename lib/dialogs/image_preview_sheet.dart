import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mabrook/l10n/l10n.dart';
import 'package:mabrook/utility/colors.dart';
import 'package:mabrook/utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ImagePreviewSheet extends StatefulWidget {
  String imagePath;
  final void Function(FileTypeOptions) optionSelected;

  ImagePreviewSheet({Key? key, required this.imagePath, required this.optionSelected}) : super(key: key);

  @override
  State<ImagePreviewSheet> createState() => _ImagePreviewSheetState();
}

class _ImagePreviewSheetState extends State<ImagePreviewSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(context.l10n.profile_image,
                style: const TextStyle(color: Colors.black, fontSize: 24)),
            Expanded(child: Container()),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, true);
                  },
                  child: const Icon(Icons.clear)),
            ),
          ],
        ),
        Text(context.l10n.please_select_any_to_continue,
                style: const TextStyle(color: MabrookColor.fadedBlack, fontSize: 16))
            .pOnly(top: 8),
        Center(
          child: CachedNetworkImage(
            imageUrl: widget.imagePath,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(),
            errorWidget: (context, url, error) => Container(),
            imageBuilder: (context, image) => CircleAvatar(
              backgroundImage: image,
              radius: 100,
            ),
          ).pOnly(top: 30, bottom: 20),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: MabrookColor.mediumDarkBlue,
                    onPrimary: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 3,
                    minimumSize: const Size(10, 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.optionSelected(FileTypeOptions.camera);
                  },
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      context.l10n.take_from_camera,
                      style: const TextStyle(fontSize: 16),
                    ).pOnly(top: 16, bottom: 16),
                  )),
            ),
            Container(width: 16),
            Expanded(
              child: OutlinedButton(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    context.l10n.pick_from_gallery,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  primary: MabrookColor.mediumDarkBlue,
                  backgroundColor: MabrookColor.white,
                  side: const BorderSide(
                      color: MabrookColor.mediumDarkBlue, width: 1),
                  shadowColor: Colors.grey,
                  elevation: 3,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  minimumSize: const Size(20, 50),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  widget.optionSelected(FileTypeOptions.gallery);
                },
              ),
            )
          ],
        ).pOnly(bottom: 30)
      ],
    ).p(20);
  }
}
