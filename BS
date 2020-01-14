/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bs;

import java.util.*;

/**
 *
 * @author sammyschutz
 */
public class BSFull implements Playable {

    //players[0] is always the actual player
    private Deck[] players; //array of players depending on how many players the user wants to play against
    private Deck pot = new Deck(); //a deck representing the pot
    int currentValue = 2; //current value of card due to play
    int numCardsPutDown = 0; //number of cards the player just put down
    int numCompCardsDown = 0; // number of CP cards put down

    @Override
    public String getName() {
        return "GAME 1: BS";
    }

    @Override
    public String getDirections() {
        return "!!!!!DIRECTIONS!!!!!\n"
                + "-Distribute the cards evenly between players\n"
                + "-Player with Ace of Spades places card in the pot\n"
                + "-Go from player to player and log what card you are on as you go\n"
                + "-When your turn decide how many of that card you’ll say you have\n"
                + "-Call BS if you think the person is lying\n"
                + "-Keep playing while everyone has at least 1 card";
    }

    @Override
    /**
     * allows for the game to be played via a main method
     */
    public void play() {
        setUpGame(); //method to set up game
        System.out.println("Here are your cards\n" + players[0]); //prints cards after the game is set up
        while (gameOver() == false) {
            takeTurns(); //alternates turns
        }
    }

    /**
     * Asks the user for an integer representing the number of cards of a
     * particular value they have
     *
     * @param prompt a prompt asking the user to put down cards
     * @return the inputted number
     */
    public static int getIntFromUser(String prompt) {
        Scanner sc = new Scanner(System.in);
        System.out.println(prompt);
        return sc.nextInt();
    }

    /**
     * Asks the user for a string
     *
     * @param prompt a prompt asking the user for a string
     * @return the inputted String
     */
    public static String getStringFromUser(String prompt) {
        Scanner sc = new Scanner(System.in);
        System.out.println(prompt);
        return sc.nextLine();
    }

    /**
     * creates an array of players
     *
     * @return the number of players playing including the regular player
     */
    public int createPlayers() {
        int numPlayers = getIntFromUser("Enter how many players you would like to play with including yourself.");
        while (numPlayers <= 0 || numPlayers > 52) {
            System.out.println("The number of players you entered in invalid. Please enter a new number.");
            Scanner sc = new Scanner(System.in);
            if (sc.hasNextInt()) {
                numPlayers = sc.nextInt();
            }
        }
        players = new Deck[numPlayers];
        return numPlayers;
    }

    /**
     * Sets up the game by dealing out the cards evenly
     */
    public void setUpGame() {
        Deck fullDeck = Deck.fullDeck();
        fullDeck.shuffle();
        try {
            createPlayers();
            for (int i = 0; i < players.length; i++) {
                players[i] = fullDeck.deal(52 / players.length);
            }
            int leftovers = fullDeck.size() % players.length;
            for (int i = 0; i < leftovers; i++) {
                players[i].add(fullDeck.deal());
            }
        } catch (InputMismatchException e) {
            System.out.println("You entered something that is not a number. You can't break this program.");
            createPlayers();
        }
    }

    /**
     * if a player has 0 cards left, the game ends
     *
     * @return boolean to determine if game is over or not
     */
    public boolean gameOver() {
        for (int i = 0; i < players.length; i++) {
            if (players[i].size() == 0) {
                if (i == 0) {
                    System.out.println("YOU WON CONGRATULATIONS!!!!!!!!!");
                } else {
                    System.out.println("YOU LOST TO A COMPUTER");
                }
                return true;
            }
        }
        return false;
    }

    /**
     * plays the game alternating between player turn and computer turn
     */
    public void takeTurns() {
        while (currentValue <= 14) {
            String prompt = "default prompt";
            if (currentValue >= 2 && currentValue <= 10 && gameOver() == false) {
                prompt = "Put down the actual number of " + currentValue + "'s you have. You will have the chance to lie later.";
            } else if (currentValue == 11 && gameOver() == false) {
                prompt = "Put down the actual number of jacks you have. You will have the chance to lie later.";
            } else if (currentValue == 12 && gameOver() == false) {
                prompt = "Put down the actual number of queens you have. You will have the chance to lie later.";
            } else if (currentValue == 13 && gameOver() == false) {
                prompt = "Put down the actual number of kings you have. You will have the chance to lie later.";
            } else if (currentValue == 14 && gameOver() == false) {
                prompt = "Put down the actual number of aces you have. You will have the chance to lie later.";
            }
            try {
                int playerCards = getIntFromUser(prompt);
                while (playerCards < 0 || playerCards > 4) {
                    System.out.println("Clearly you do not understand the rules. You can't put down a number greater than 4 or less than 1.");
                    Scanner userInput = new Scanner(System.in);
                    if (userInput.hasNextInt()) {
                        playerCards = userInput.nextInt();
                    }
                }
                int counter = addPlayerCards(); //puts player's cards in pot
                checkIfPlayerToldTruth(playerCards, counter);
                int numCardsLying = userLie(counter);
                putLyingCardsDown(numCardsLying, counter);
                checkIfPlayerPutDownCards(counter);
            } catch (InputMismatchException ex) {
                System.out.println("You entered something that is not a number. You can't break this program. The right number of cards \nwas automatically added to the pot. If you had 0 of the right cards, a card was put down for you.");
                inputMismatchByUser();
            }
            int i = computerCallBS();
            checkDeckForLie(i);
            if (gameOver() == true) {
                currentValue = 15;
            } else if (gameOver() == false) {
                numCompCardsDown = 0;
                computerTurn();//current value is reset after computer player turns are done
            }
            if (gameOver() == true) {
                currentValue = 15;
            } else {
                System.out.println("****YOUR TURN...Here are your cards\n" + players[0]); //prints deck after round
                numCardsPutDown = 0;
                numCompCardsDown = 0;
            }
        }
    }

    /**
     * puts the computer cards in the deck from each computer player depending
     * on what round the game is on
     *
     * @return
     */
    public int computerTurn() {
        for (int i = 1; i < players.length; i++) {
            currentValue++;
            if (currentValue > 14) {
                currentValue = 2;
            }
            System.out.println("######################## COMPUTER PLAYER " + i + " 'S TURN ########################");
            int counter = 0;
            for (int x = 0; x < players[i].size(); x++) {
                if (players[i].get(x).getValue() == currentValue) {
                    Card c = players[i].deal(players[i].get(x));
                    pot.add(c);
                    counter++;
                }
            }
            numCompCardsDown = counter;
            singleLie(counter, i);
            printCompCard(i);
            //System.out.println("Pot:" + pot);
            System.out.println("****NOTE: There are currently " + pot.size() + " cards in the pot.****");
            callBS(i);

            numCompCardsDown = 0;
        }
        currentValue++;
        if (currentValue > 14) {
            currentValue = 2;
        }
        return currentValue;
    }

    /**
     * prints the correct prompts
     *
     * @return the number of cards the player says he has
     */
    public int printPrompt() {
        String prompt = "default prompt";
        if (currentValue >= 2 && currentValue <= 10 && gameOver() == false) {
            prompt = "Put down the actual number of " + currentValue + "'s you have. Don't lie this time.";
        } else if (currentValue == 11 && gameOver() == false) {
            prompt = "Put down the actual number of jacks you have. Don't lie this time.";
        } else if (currentValue == 12 && gameOver() == false) {
            prompt = "Put down the actual number of queens you have. Don't lie this time.";
        } else if (currentValue == 13 && gameOver() == false) {
            prompt = "Put down the actual number of kings you have. Don't lie this time.";
        } else if (currentValue == 14 && gameOver() == false) {
            prompt = "Put down the actual number of aces you have. Don't lie this time.";
        }
        int playerCards = getIntFromUser(prompt);
        return playerCards;
    }

    /**
     * checks to see if the user has the current card number
     *
     * @return true or false based on if the user has the current card
     */
    public boolean hasRightCards() {
        int counter = 0;
        for (int x = pot.size() - numCardsPutDown; x < pot.size(); x++) {
            if (pot.get(x).getValue() == currentValue) {
                counter++;
            }
        }
        if (counter == 0) {
            return false;
        }
        return true;
    }

    /**
     * deals with an mismatch exception by the user
     */
    public void inputMismatchByUser() {
        if (hasRightCards() == false) {
            numCardsPutDown = 1;
            Card c = players[0].deal();
            pot.add(c);
        }
    }

    /**
     * checks if player told truth about the actual number of cards he has
     *
     * @param playerCards the number of cards the player says he has
     * @param counter the number he actually has
     */
    public void checkIfPlayerToldTruth(int playerCards, int counter) {
        while (playerCards != counter) {
            if (currentValue >= 2 && currentValue <= 10 && (playerCards >= 0 && playerCards <= 4)) {
                System.out.println("You don't have " + playerCards + " " + currentValue + "'s. Stop trying to lie. You have " + counter + " " + currentValue + "'s.");
            } else if (currentValue == 11 && (playerCards >= 0 && playerCards <= 4)) {
                System.out.println("You don't have " + playerCards + " jacks. Stop trying to lie. You have " + counter + " jacks.");
            } else if (currentValue == 12 && (playerCards >= 0 && playerCards <= 4)) {
                System.out.println("You don't have " + playerCards + " queens. Stop trying to lie. You have " + counter + " queens.");
            } else if (currentValue == 13 && (playerCards >= 0 && playerCards <= 4)) {
                System.out.println("You don't have " + playerCards + " kings. Stop trying to lie. You have " + counter + " kings.");
            } else if (currentValue == 14 && (playerCards >= 0 && playerCards <= 4)) {
                System.out.println("You don't have " + playerCards + " aces. Stop trying to lie. You have " + counter + " aces.");
            } else {
                System.out.println("Clearly you do not understand the rules. You can't put down a number greater than 4 or less than 1.");
            }
            playerCards = printPrompt();
        }
    }

    /**
     * checks the player's deck to see if any matching cards exist and if they
     * do it adds them to the pot
     *
     * @return counter
     */
    public int addPlayerCards() {
        int counter = 0;
        for (int x = 0; x < players[0].size(); x++) {
            if (players[0].get(x).getValue() == currentValue) {
                Card c = players[0].deal(players[0].get(x));
                pot.add(c);
                counter++;
                numCardsPutDown++;
            }
        }
        return counter;
    }

    /**
     * makes sure that the player actually puts down a card
     *
     * @param counter the number of actual cards that the player has
     */
    public void checkIfPlayerPutDownCards(int counter) {
        while (counter == 0 && numCardsPutDown == 0) {
            System.out.println("You cannot put 0 cards down. Stop trying to cheat. Put down the number of cards you want to put down.");
            int numCardsLying = userLie(counter);
            putLyingCardsDown(numCardsLying, counter);
        }
    }

    /**
     * allows for proper printing of the current card number
     *
     * @param i the computer player who's turn it is
     */
    public void printCompCard(int i) {
        if (currentValue >= 2 && currentValue <= 10) {
            System.out.println("Computer Player " + i + " put down " + numCompCardsDown + " " + currentValue + "'s");
        } else if (currentValue == 11) {
            System.out.println("Computer Player " + i + " put down " + numCompCardsDown + " jacks");
        } else if (currentValue == 12) {
            System.out.println("Computer Player " + i + " put down " + numCompCardsDown + " queens");
        } else if (currentValue == 13) {
            System.out.println("Computer Player " + i + " put down " + numCompCardsDown + " kings");
        } else if (currentValue == 14) {
            System.out.println("Computer Player " + i + " put down " + numCompCardsDown + " aces");
        }
    }

    /**
     * asks the user if he wants to lie about the number of cards he has
     *
     * @param counter number of actual current cards
     * @return the number of cards lying about
     */
    public int userLie(int counter) { // remember need to impelment a counter into the check player cards method
        String lies = getStringFromUser("Would you like to lie?");
        if (lies.equalsIgnoreCase("yes")) {
            int numCardsLying = getIntFromUser("How many cards would you like to lie about?");
            int totalCards = numCardsLying + counter;
            while (totalCards > 4) {
                System.out.println("****NOTE: You put down a total number of cards greater than 4 please enter a valid number of cards to lie about. Note you need to take into account the number of cards that you are not lying about****");
                Scanner sc = new Scanner(System.in);
                if (sc.hasNextInt()) {
                    numCardsLying = sc.nextInt();
                }
                if (numCardsLying + counter <= 4) {
                    totalCards = numCardsLying + counter;
                }
            }
            return numCardsLying;
        } else {
            return 0;
        }
    }

    /**
     * puts down the proper number of cards that the user wants to lie about
     *
     * @param numCardsLying
     * @param counter number actual cards
     */
    public void putLyingCardsDown(int numCardsLying, int counter) {
        if (numCardsLying == 0) {
            addPlayerCards();
        } else if (numCardsLying == 1) {
            numCardsPutDown = numCardsPutDown + 1;
            Card pCard = players[0].deal();
            pot.add(pCard);
        } else if (numCardsLying == 2) {
            numCardsPutDown = numCardsPutDown + 2;
            Card pCard1 = players[0].deal();
            pot.add(pCard1);
            Card pCard2 = players[0].deal();
            pot.add(pCard2);
        } else if (numCardsLying == 3) {
            numCardsPutDown = numCardsPutDown + 3;
            Card pCard1 = players[0].deal();
            pot.add(pCard1);
            Card pCard2 = players[0].deal();
            pot.add(pCard2);
            Card pCard3 = players[0].deal();
            pot.add(pCard3);
        } else if (numCardsLying == 4) {
            numCardsPutDown = 4;
            Card pCard1 = players[0].deal();
            pot.add(pCard1);
            Card pCard2 = players[0].deal();
            pot.add(pCard2);
            Card pCard3 = players[0].deal();
            pot.add(pCard3);
            Card pCard4 = players[0].deal();
            pot.add(pCard4);
        }
    }

    /**
     * asks user if he wants to call BS
     *
     * @return yes or no depending on if user wants to call BS
     */
    public String askUserIfCallBS() {
        System.out.println("****NOTE: Here are your cards****\n" + players[0]);
        String bs = getStringFromUser("Would you like to call BS on the last computer turn?");
        if (bs.equalsIgnoreCase("yes")) {
            return "yes";
        } else {
            return "no";
        }
    }

    /**
     * allows the user to call bs on the computer players
     *
     * @param i the computer player to call bs on
     */
    public void callBS(int i) {
        if (askUserIfCallBS().equalsIgnoreCase("yes")) {
            int count = 0;
            for (int x = pot.size() - numCompCardsDown; x < pot.size(); x++) {
                if (pot.get(x).getValue() == currentValue) {
                    count++;
                }
            }
            if (count != numCompCardsDown) {
                System.out.println("****You called BS successfully and Computer Player " + i + " took the pot****");
                players[i].add(pot);
            } else {
                System.out.println("****Computer Player " + i + " told the truth and you took the pot****");
                players[0].add(pot);
            }
        }
    }

    /**
     * checks to see if a computer player will call bs
     *
     * @return the computer player that calls bs
     */
    public int computerCallBS() {
        int probabilityToCall = 0; //percent chance to call bs
        for (int i = 1; i < players.length; i++) {
            if (numCardsPutDown == 1) {
                probabilityToCall = 5; // 10
            } else if (numCardsPutDown == 2) {
                probabilityToCall = 15; // 20
            } else if (numCardsPutDown == 3) {
                probabilityToCall = 25; // 35
            } else {
                probabilityToCall = 50; //60
            }
            int testArr[] = new int[100];
            for (int j = 0; j < probabilityToCall; j++) {
                testArr[j] = 1;
            }
            for (int x = probabilityToCall; x < 100 - probabilityToCall; x++) {
                testArr[x] = 0;
            }
            int randIndex = new Random().nextInt(testArr.length);
            int rand = testArr[randIndex];
            if (rand == 1) {
                return i;
            }
        }
        return 0;
    }

    /**
     * checks to see if the bs call by computer is appropriate
     *
     * @param i the computer player to call bs
     */
    public void checkDeckForLie(int i) {
        int counter = 0;
        if (i != 0) {
            for (int x = pot.size() - numCardsPutDown; x < pot.size(); x++) {
                if (pot.get(x).getValue() == currentValue) {
                    counter++;
                }
            }
            if (counter != numCardsPutDown) {
                players[0].add(pot);
                System.out.println("****Computer Player " + i + " called BS and you were lying. You took the pot.****");
                System.out.println("Here are your cards\n" + players[0]);
            } else if (counter == numCardsPutDown) {
                players[i].add(pot);
                System.out.println("****Computer Player " + i + " called BS and you told the truth. They took the pot.****");
            }
        }
    }

    /**
     * accounts for a computer player telling a single card lie when they do not
     * have any of the current card
     *
     * @param counter represents the number of the current card that the CP has
     * @param i the current computer player
     */
    public void singleLie(int counter, int i) {
        if (counter == 0) {
            numCompCardsDown = 1;
            Card c = players[i].deal();
            pot.add(c);
        } else {
            computerLie(i);
        }
    }
