using System;
using BingoCard;

namespace AoCDay4 {
    class MainClass {
        private static string ReadFile(string filename) {
            string text = System.IO.File.ReadAllText(filename);
            return text;
        }
        public static void Main (string[] args) {
            // Read input data
            string text = ReadFile(args[0]);
            
            // Split into lines
            string[] lines = text.Split('\n');
            // Get the values that were called
            string[] s_calls = lines[0].Split(',');
            int[] calls = new int[s_calls.Length];
            for (int i=0; i<s_calls.Length; i++)
            {
                calls[i] = Int32.Parse(s_calls[i]);
            }


            // Get cards
            Card[] cards = new Card[5];
            int card_index = 0;
            int row_number = 0;
            foreach (string line in new ArraySegment<string>(lines, 1, lines.Length -1 )) {
                // in each line if it is not a blank line
                if (line.Length > 0) {
                    string[] values = line.Split(' ');
                    for (int col_index=0; col_index < values.Length; col_index++) {
                        Console.Write(cards[0].cells);
                        
                        cards[card_index].cells[row_number, col_index].value = Int32.Parse(values[col_index]);
                    }
                    row_number++;
                } else {
                    card_index++;
                    row_number=0;
                }
            }
            Console.Write(cards);
        }
    }
}