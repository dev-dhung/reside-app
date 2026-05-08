import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart' as xls;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prototype/core/services/file_saver.dart';

class ExportColumn<T> {
  final String header;
  final String Function(T row) field;

  const ExportColumn({required this.header, required this.field});
}

class ExportService {
  ExportService._();
  static final ExportService instance = ExportService._();

  Future<void> exportToCsv<T>({
    required String filename,
    required List<ExportColumn<T>> columns,
    required List<T> rows,
  }) async {
    final data = <List<String>>[
      columns.map((c) => c.header).toList(),
      ...rows.map((r) => columns.map((c) => c.field(r)).toList()),
    ];
    final csv = const ListToCsvConverter().convert(data);
    final bytes = Uint8List.fromList(
      [0xEF, 0xBB, 0xBF, ...csv.codeUnits],
    );

    await saveAndShareFile(bytes, '$filename.csv', 'text/csv');
  }

  Future<void> exportToXlsx<T>({
    required String filename,
    required String sheetName,
    required List<ExportColumn<T>> columns,
    required List<T> rows,
  }) async {
    final excel = xls.Excel.createExcel();
    final safeSheet =
        sheetName.length > 31 ? sheetName.substring(0, 31) : sheetName;

    excel.rename(excel.getDefaultSheet() ?? 'Sheet1', safeSheet);
    final sheet = excel[safeSheet];

    sheet.appendRow(
      columns.map<xls.CellValue?>((c) => xls.TextCellValue(c.header)).toList(),
    );

    for (final r in rows) {
      sheet.appendRow(
        columns
            .map<xls.CellValue?>((c) => xls.TextCellValue(c.field(r)))
            .toList(),
      );
    }

    final headerStyle = xls.CellStyle(
      bold: true,
      fontColorHex: xls.ExcelColor.white,
      backgroundColorHex: xls.ExcelColor.fromHexString('#2D6A4F'),
      horizontalAlign: xls.HorizontalAlign.Center,
    );
    for (var i = 0; i < columns.length; i++) {
      sheet
          .cell(xls.CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .cellStyle = headerStyle;
      sheet.setColumnWidth(i, 20);
    }

    final encoded = excel.save();
    if (encoded == null) {
      throw StateError('No se pudo generar el archivo Excel.');
    }

    await saveAndShareFile(
      Uint8List.fromList(encoded),
      '$filename.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    );
  }

  Future<void> exportToPdf<T>({
    required String filename,
    required String title,
    required List<ExportColumn<T>> columns,
    required List<T> rows,
  }) async {
    final doc = pw.Document();
    final generatedAt = DateTime.now();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(28),
        header: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'SIGRA - Sistema de Gestión de Residencias',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromInt(0xFF2D6A4F),
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              title,
              style: const pw.TextStyle(fontSize: 12),
            ),
            pw.SizedBox(height: 2),
            pw.Text(
              'Generado: ${_formatDateTime(generatedAt)}',
              style: pw.TextStyle(
                fontSize: 9,
                color: PdfColor.fromInt(0xFF777777),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Divider(color: PdfColor.fromInt(0xFFCCCCCC), height: 1),
            pw.SizedBox(height: 10),
          ],
        ),
        footer: (ctx) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 8),
          child: pw.Text(
            'Página ${ctx.pageNumber} de ${ctx.pagesCount}',
            style: pw.TextStyle(
              fontSize: 9,
              color: PdfColor.fromInt(0xFF999999),
            ),
          ),
        ),
        build: (ctx) => [
          pw.TableHelper.fromTextArray(
            headers: columns.map((c) => c.header).toList(),
            data: rows
                .map((r) => columns.map((c) => c.field(r)).toList())
                .toList(),
            headerStyle: pw.TextStyle(
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
              fontSize: 10,
            ),
            headerDecoration: pw.BoxDecoration(
              color: PdfColor.fromInt(0xFF2D6A4F),
            ),
            cellStyle: const pw.TextStyle(fontSize: 9),
            cellPadding: const pw.EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 4,
            ),
            oddRowDecoration: pw.BoxDecoration(
              color: PdfColor.fromInt(0xFFF5F7FA),
            ),
            border: pw.TableBorder.all(
              color: PdfColor.fromInt(0xFFE0E0E0),
              width: 0.5,
            ),
          ),
        ],
      ),
    );

    final bytes = await doc.save();
    await Printing.sharePdf(bytes: bytes, filename: '$filename.pdf');
  }

  String _formatDateTime(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(dt.day)}/${two(dt.month)}/${dt.year} '
        '${two(dt.hour)}:${two(dt.minute)}';
  }
}
