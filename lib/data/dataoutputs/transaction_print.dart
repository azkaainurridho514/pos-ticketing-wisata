import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:intl/intl.dart';

class TransactionPrint {
  TransactionPrint._init();
  static final TransactionPrint instance = TransactionPrint._init();
  Future<List<int>> printQRCode(String qrCode) async {
    List<int> bytes = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    bytes += generator.reset();
    bytes += generator.text("CINTA.ID",
        styles: const PosStyles(
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          align: PosAlign.center,
        ));

    bytes += generator.text("Pembayaran QRIS",
        styles: const PosStyles(
          bold: true,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          align: PosAlign.center,
        ));
    bytes += generator.feed(1);
    bytes += generator.text(
        "Tanggal : ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
        styles: const PosStyles(
          bold: false,
          align: PosAlign.center,
        ));
    bytes += generator.feed(1);
    bytes += generator.qrcode(qrCode, size: QRSize.size6, cor: QRCorrection.H);
    bytes += generator.feed(1);
    bytes += generator.text("~ Terimakasih ~",
        styles: const PosStyles(
          bold: true,
          align: PosAlign.center,
        ));
    bytes += generator.feed(3);
    return bytes;
  }
}
