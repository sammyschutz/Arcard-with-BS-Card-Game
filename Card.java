/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bs;

/**
 *
 * @author sammyschutz
 */
import java.util.*;

/**
 * The Card class is an instantiable class used to represent a typical playing
 * card in a standard 52 card deck. A Card is not modifiable after it is
 * created, except for the points associated with the Card.
 */
public class Card implements Comparable<Card> {

    //##################### DATA MEMBERS ##################
    private final Suit suit;
    private final int value; //2-14
    private int points;
    private String display;
    private final boolean isBlack;
    private boolean faceUp;

    //##################### CONSTRUCTOR ###################
    /**
     * The standard constructor takes in a value and a suit. The constructor
     * assigns the value and suit of the card, which are finalized, and sets
     * points to be the same as the value. It also determines whether or not the
     * card is black and generates the display. By default faceUp is set to true;
     *
     * @param inValue int that represents the value of the card 2(2) - 14(Ace),
     * for any value outside of the acceptable range the value is changed to 0
     * to indicate a non-valid card.
     * @param inSuit Suit type that identifies the suit of the card
     */
    public Card(int inValue, Suit inSuit) {
        if (inValue < 2 || inValue > 14) {
            value = 0;
        } else {
            value = inValue;
        }
        points = inValue;
        suit = inSuit;
        faceUp = true;

        if (suit == Suit.CLUBS || suit == Suit.SPADES) {
            isBlack = true;
        } else {
            isBlack = false;
        }
        createDisplay();
    }

    /**
     * This method generates the display (a String) for the Card based on its
     * value and suit. The format of the created display is: "value - suit"
     * where values 2-10 are numeric and values 11-14 are single capital letters
     * (JQKA). The suit is represented as a unicode version of that suit. Any
     * card created with an unacceptable value is forced to a 0 and the display
     * becomes "JOKER".
     */
    private void createDisplay() {
        if( value == 0){
         display = "JOKER";
        }
        else{
        if (value == 14) {
            display = "A - ";
        } else if (value == 11) {
            display = "J - ";
        } else if (value == 12) {
            display = "Q - ";
        } else if (value == 13) {
            display = "K - ";
        } else {
            display = value + " - ";
        }

        switch (suit) {
            case HEARTS:
                display += (char) 9829;
                break;
            case CLUBS:
                display += (char) 9827;
                break;
            case DIAMONDS:
                display += (char) 9830;
                break;
            case SPADES:
                display += (char) 9824;
                break;
        }
        }
    }

    /**
     * This is an override of the inherited method toString from the Object
     * class. The method returns the display data member, which is created
     * automatically in the constructor, if the card is faceup. If the card is
     * not faceup it returns a generic symbol to represent the back of a card.
     *
     * @return a string that displays the value and suit of the card
     * @see Object
     */
    @Override
    public String toString() {
        if(faceUp){
            return "[" + display + "]";
        }
        return "[XXXXX]";
    }

    public boolean equals(Card c){
        return this.suit == c.suit && this.value == c.value;  
    }
    
    /**
     * compareTo is a method that is inherited by the interface comparable.
     *
     * This method compares the values of the cards only and returns
     *
     * @param inCard a card to which this card's value is to be compared
     * @return the difference between the cards' values.
     *
     * for example: ten.compareTo(ten): 10-10 = 0 five.compareTo(ace): 5-14 =
     * -9 ace.compareTo(five): 14-5 = 9
     */
    public int compareTo(Card inCard) {
        return value - inCard.value;//Can see private values b/c each are cards
    }
    
    /**
     * Changes the state of faceUp to its opposite.
     */
    public void flip(){
        faceUp = !faceUp;
    }

    //###################### ACCESSORS/SETTORS ###################
   /**
    * Returns the state of the data member faceUp
    * @return true if the card is faceUp, false otherwise
    */
    public boolean faceUp(){
       return faceUp;
   }
    
    /**
     * @return the value of the data member suit
     */
    public Suit getSuit() {
        return suit;
    }

    /**
     * @return the value of the data member value
     */
    public int getValue() {
        return value;
    }

    /**
     * @return the value of the data member points
     */
    public int getPoints() {
        return points;
    }
    
    /**
     * @param inPoints is the value to which points should be set
     */
    public void setPoints(int inPoints) {
        points = inPoints;
    }

    /**
     * @return the value of the data member isBlack
     */
    public boolean isBlack() {
        return isBlack;
    }
}
