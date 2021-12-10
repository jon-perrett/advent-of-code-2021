import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:quiver/iterables.dart';
import 'dart:math';

const lineNumber = 'line-number';

void main(List<String> arguments) {
  exitCode = 0; // presume success
  final parser = ArgParser();

  ArgResults argResults = parser.parse(arguments);
  final path = argResults.rest[0];

  process_files(path);
}

Future<void> process_files(String path) async {
  if (path.isEmpty) {
    // No files provided as arguments. Read from stdin and print each line.
    await stdin.pipe(stdout);
  } else {
    
    var lineNumber = 1;
    final lines = utf8.decoder
        .bind(File(path).openRead())
        .transform(const LineSplitter());
    try {
      int row = 1000;
      int col = 1000;

      var grid = List.generate(row, (i) => List.generate(col, (_)=>0), growable: false);
      await for (final line in lines) {
        var coords = line.split(' -> ');
        var from = coords[0].split(',');
        var to = coords[1].split(',');

        bool vertical = from[0] == to[0];
        bool horizontal = from[1] == to[1];
        bool diag = (!vertical && !horizontal);
        if (!diag){
          if (horizontal) {
            var min_x = [int.parse(from[0]),int.parse(to[0])].reduce((curr, next) => curr < next? curr: next);
            var max_x = [int.parse(from[0]),int.parse(to[0])].reduce((curr, next) => curr > next? curr: next);
            
            int const_y = int.parse(from[1]);
            var xs = [for (var i = min_x; i <= max_x; i+=1) i];
            var ys = [for (var i = min_x; i <= max_x; i+=1) const_y];
            for (var pair in zip([xs, ys])) {
              var x = pair[0];
              var y = pair[1];
              grid[x][y]++;
            }
          }
          if (vertical) {
            
            var min_y = [int.parse(from[1]), int.parse(to[1])].reduce((curr, next) => curr < next? curr: next);
            var max_y = [int.parse(from[1]), int.parse(to[1])].reduce((curr, next) => curr > next? curr: next);
            int const_x = int.parse(from[0]);
            
            var xs = [for (var i =min_y; i <= max_y; i+=1) const_x];
            var ys = [for (var i =min_y; i <= max_y; i+=1) i];
            for (var pair in zip([xs, ys])) {
              var x = pair[0];
              var y = pair[1];
              
              grid[x][y]++;
            }
          }
        }
      }
      // stdout.writeln(grid);
      int counter=0;
      grid.forEach((row) => row.forEach((col) => col > 1 ? counter++ : null));
      stdout.write(counter);
    } catch (_) {
      await _handleError(path);
    }
  }
}

Future<void> _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
