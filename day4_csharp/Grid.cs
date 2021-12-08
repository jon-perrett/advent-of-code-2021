namespace BingoCard {
    public class Cell {
        public bool isChecked;
        public int value;
    }
    public class Card {
        public Card() {
            this.cells=InitialiseGrid(5);
        }
        public Cell[,] cells = InitialiseGrid(5);
        public static Cell[,] InitialiseGrid(int dim) {
            Cell[,] newCells = new Cell[dim,dim];
            for (int i=0; i<dim; i++) {
                for (int j=0; j<dim; j++) {
                    newCells[i, j] = new Cell();
                }
            }
            return newCells;
        }
    }
}