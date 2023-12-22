import 'dart:io';

class Play
{
  late List<String> cells;

  Play()
  {
    cells = List.generate(9, (index) => (index + 1).toString());
  }

  void printBoard() 
  {
    for (int i = 0; i < 9; i += 3) {
      print('${cells[i]} | ${cells[i + 1]} | ${cells[i + 2]}');
      if (i < 6) print('---------');
    }
  }

  bool isCellUsed(int position) 
  {
    return cells[position - 1] == 'X' || cells[position - 1] == 'O';
  }

  void occupyCell(int position, String player)
  {
    cells[position - 1] = player;
  }

  bool checkWin(String player) 
  {
    for (int i = 0; i < 3; i++) {
      if (cells[i] == player && cells[i + 3] == player && cells[i + 6] == player) {
        return true; // Check columns
      }
      if (cells[i * 3] == player && cells[i * 3 + 1] == player && cells[i * 3 + 2] == player) {
        return true; // Check rows
      }
    }

    if (cells[0] == player && cells[4] == player && cells[8] == player) 
    {
      return true; // Check diagonal (top-left to bottom-right)
    }
    if (cells[2] == player && cells[4] == player && cells[6] == player) 
    {
      return true; // Check diagonal (top-right to bottom-left)
    }

    return false;
  }

  bool isBoardFull() {
    return !cells.contains('1')
        && !cells.contains('2')
        && !cells.contains('3')
        && !cells.contains('4')
        && !cells.contains('5')
        && !cells.contains('6')
        && !cells.contains('7')
        && !cells.contains('8')
        && !cells.contains('9');
  }
}

class XOGame {
  late Play board;
  late String currentPlayer;

  XOGame() {
    board = Play();
    currentPlayer = 'X';
  }

  void NextPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void play() {
    int? move;
    bool correct;

    do {
      board.printBoard();
      print('other player move please  Enter your move (1-9):');
      move = int.tryParse(stdin.readLineSync() ?? '');

      correct = !board.isCellUsed(move ?? 0);

      if (!correct) {
        print('wrong input');
      }

    } while (!correct);

    board.occupyCell(move ?? 0, currentPlayer);

    if (board.checkWin(currentPlayer))
    {
      board.printBoard();
      print(' $currentPlayer wins!');
    }
    else if (board.isBoardFull())
    {
      board.printBoard();
      print('It\'s a tie!');
    }
    else
    {
      NextPlayer();
      play();
    }
  }
}

void main() {
  do {
    XOGame game = XOGame();
    game.play();

    print('play again? (yes/no):');
  } while (stdin.readLineSync()?.toLowerCase() == 'yes');
}
