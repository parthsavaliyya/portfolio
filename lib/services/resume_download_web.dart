import 'dart:js_interop';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:flutter/services.dart' show rootBundle;
import 'package:web/web.dart' as web;

Future<void> downloadResume() async {
  if (!kIsWeb) {
    print("Download only supported on web");
    return;
  }

  try {
    // Load PDF bytes from assets
    final byteData = await rootBundle.load('assets/doc/parth_flutter.pdf');
    final Uint8List bytes = byteData.buffer.asUint8List();

    // 1. Convert Dart Uint8List → JS Uint8Array using dart:js_interop
    final jsBytes = bytes.toJS;

    // 2. Create Blob parts array
    final blobParts = [jsBytes].toJS;

    // 3. Create Blob with correct MIME type
    final blob = web.Blob(
      blobParts,
      web.BlobPropertyBag(type: 'application/pdf'),
    );

    // 4. Create object URL
    final url = web.URL.createObjectURL(blob);

    // 5. Trigger download via hidden anchor
    final anchor = web.HTMLAnchorElement()
      ..href = url
      ..download = 'Parth_Savaliya_Resume.pdf'
      ..style.display = 'none';

    web.document.body!.append(anchor);
    anchor.click();

    // 6. Cleanup
    web.document.body!.removeChild(anchor);
    web.URL.revokeObjectURL(url);
  } catch (e) {
    print("Download failed: $e");
    // You can show a SnackBar here if you have context
  }
}
