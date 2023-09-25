import java.util.*;

public class main {
	public static void main(String[] args) {
		// Create instance of random class
		Random rand = new Random();
		// Set int wrongGuess to 0
		int wrongGuesses = 0;
		// Set boolean gameWon to false
		// Set boolean gameLost to false
		// Set boolean playAgain to false
		boolean gameWon = false, gameLost = false;
		int playAgainNum;
		// Declare array for words
		String[] wordList = { "hangman", "int", "elephants" };
		// Set word equal to a random number that is the length of the array
		int randomWord = rand.nextInt(wordList.length);
		String word = wordList[randomWord];
		// Split the word into its individual characters
		// Replace all letters in word with a blank
		String blankWord = makeHiddenWord(word);
		// new String(new char[word.length()]).replace("\0", "_");
		// Create instance of scanner
		Scanner scan = new Scanner(System.in);
		// Declare arraylist for pastguesses
		ArrayList<Character> list = new ArrayList<>();
		// Print welcome statement
		System.out.println("Welcome to hangman! A word will be " + "displayed and you will "
				+ "have six incorrect guesses to figure out what it is. " + "Let’s get started!");
		do {
			do {
				// Game logic
				System.out.println("Guess a letter:");
				System.out.println(blankWord);
				char guess = scan.next().charAt(0);
				// Compare current guess to past guesses
				// for (int i = 0; i < list.; i++)
				if (list.contains(guess)) {
					System.out.println("You've already guessed that. Try " + "again!");
				} else {
					list.add(guess);
					for (int i = 0; i < word.length();) {
						if (word.charAt(i) == guess) {
							System.out.println("Correct! " + guess + " is in the word.");
							blankWord = revealChar(guess, word, blankWord);
							printHangman(wrongGuesses);
							break;
						} else {
							if (guess != word.charAt(i))
								wrongGuesses++;
							printHangman(wrongGuesses);
							if (wrongGuesses == 6) {
								System.out.println("You have 6 " + "wrong guesses! Game lost.");
								gameLost = true;
							}
							break;
						}
					}
				}
			} while (!gameLost && !gameWon);
			// Check if the player has won the game
			gameWon = checkGameWon(blankWord, word);
			System.out.println("Do you want to play again? Press one to play "
					+ "again and two to quit.");
			playAgainNum = scan.nextInt();
			if (playAgainNum == 1) {
				// Reset the game variables
				wrongGuesses = 0;
				gameWon = false;
				gameLost = false;
				list.clear();
				blankWord = makeHiddenWord(word);
			} else {
				scan.close();
				System.out.println("Thanks for playing!");
			}
		} while (playAgainNum == 1);
	}

	public static String revealChar(char guess, String word, String revealed) {
		StringBuilder result = new StringBuilder(revealed);
		for (int i = 0; i < word.length(); i++) {
			if (word.charAt(i) == guess) {
				result.setCharAt(i, guess);
			}
		}
		return result.toString();
	}

	private static boolean checkGameWon(String blankWord, String word) {
		return blankWord.equals(word);
	}

	public static String makeHiddenWord(String hiddenWord) {
		StringBuilder displayWord = new StringBuilder();
		for (int i = 0; i < hiddenWord.length(); i++) {
			displayWord.append('-');
		}
		return displayWord.toString();
	}

	public static void printHangman(int wrongGuesses) {
		switch (wrongGuesses) {
			case 1:
				System.out.println("Wrong guess, try again");
				System.out.println("   ____________");
				System.out.println("   |          |");
				System.out.println("   |          |");
				System.out.println("   |          O");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("___|___");
				break;
			case 2:
				System.out.println("Wrong guess, try again");
				System.out.println("   ____________");
				System.out.println("   |          |");
				System.out.println("   |          |");
				System.out.println("   |          O");
				System.out.println("   |          |");
				System.out.println("   |          ");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("___|___");
				break;
			case 3:
				System.out.println("Wrong guess, try again");
				System.out.println("   ____________");
				System.out.println("   |          |");
				System.out.println("   |          |");
				System.out.println("   |          O");
				System.out.println("   |          |");
				System.out.println("   |         / ");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("___|___");
				break;
			case 4:
				System.out.println("Wrong guess, try again");
				System.out.println("   ____________");
				System.out.println("   |          |");
				System.out.println("   |          |");
				System.out.println("   |          O");
				System.out.println("   |          |");
				System.out.println("   |         / \\");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("___|___");
			case 5:
				System.out.println("Wrong guess, try again");
				System.out.println("   ____________");
				System.out.println("   |          |");
				System.out.println("   |          |");
				System.out.println("   |          O");
				System.out.println("   |        --|");
				System.out.println("   |         / \\");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("___|___");
				break;
			case 6:
				System.out.println("Wrong guess, try again");
				System.out.println("   ____________");
				System.out.println("   |          |");
				System.out.println("   |          |");
				System.out.println("   |          O");
				System.out.println("   |        --|--");
				System.out.println("   |         / \\");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("___|___");
				break;
			case 0:
				System.out.println("   ____________");
				System.out.println("   |          |");
				System.out.println("   |          |");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("   |");
				System.out.println("___|___");
				break;
			default:
				break;
		}
		;
	}
}