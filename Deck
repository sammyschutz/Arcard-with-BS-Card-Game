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
import java.util.ArrayList;
import java.util.Collections;

/**
 * The Deck class represents a group of Card objects. Although a Deck may
 * often refer to the 52 standard playing cards it will also be used to
 * reference any bunch of Cards together. For example, the cards that a player
 * might keep in their hand, the public cards on a table, and the cards remaining
 * in the dealer stack can all be Deck objects, composed of one set of 52 cards
 * that can be distributed in various ways.
 */
public class Deck{
    
    private ArrayList<Card> deck;
    
    /**
     * Creates a blank deck that is able to hold cards.
     */
    public Deck(){
        deck = new ArrayList<Card>();
    }
    
    /**
     * Creates and returns a standard 52 Card playing deck in the order 2 - Ace
     * for each suit at a time with CLUBS first, DIAMONDS second, HEARTS third,
     * and SPADES last.
     * @return instantiated Deck with 52 Card objects, 2 through A, for each suit
     */
    public static Deck fullDeck(){
        
        Deck deck = new Deck();
        for(int i=0; i<52; i++){
            Suit s = Suit.CLUBS;
            if(i/13==1){s = Suit.DIAMONDS;}
            if(i/13==2){s = Suit.HEARTS;}
            if(i/13==3){s = Suit.SPADES;}
            deck.add(new Card(i%13 + 2, s));
        }
        return deck;
    }
    
    
    /**
     * Adds all the cards from the Deck inCards such that inCards is empty
     * and this deck has them added in the same order to the back of the deck
     * @param inCards is a Deck from which all cards will be removed and added
     *      to this deck
     */
    public void add(Deck inCards){
        deck.addAll(inCards.deck);
        inCards.clear();
    }
    
    /**
     * Adds one card to the deck, at the back
     * @param c is a single card
     */
    public void add(Card c){
        deck.add(c);
    }
    
    /**
     * num cards are removed from the deck and returned as a Deck object. In
     * the case that there are less than num cards left in the deck whatever is
     * left is returned. All cards are taken from the front of the deck and are
     * returned in the same order from which they were removed.
     * @param num number of cards to deal from top of deck
     * @return a deck which contains the dealt cards, which could possibly be
     *      an empty deck
     */
    public Deck deal(int num){
        Deck tempDeck = new Deck();
        if(deck.size() < num){
        num = deck.size();
        }
        for(int i = 0; i<num; i++){
            tempDeck.add(deal());
        }
        return tempDeck;
    }
    
    /**
     *  Deals the front card of the deck
     * @return the top card from this deck
     */
    public Card deal(){
        return(deck.remove(0));
    }
    
    
    /**
     * Finds, removes, and returns the specified card from the deck
     * @param c is a card to be returned
     * @return the card, c, or null if it is not in the deck
     */
    public Card deal(Card c){
        for(int i = 0; i < deck.size(); i++){
            if(c.equals( deck.get(i) ) ){
               return deck.remove(i);
            }
        }
        
        return null;
            
    }
    
    /**
     * Returns the card at index cardNum in deck but does not remove it from the
     * deck. This method can be used for iterating though a deck to look at each
     * card. If no card is present at the specified index null is returned
     * @param cardNum the index of the card to get
     * @return the card at index cardNum, or null if there is no such card or
     *      the index given would be out of the bounds of the deck
     */
    public Card get(int cardNum){
        if( cardNum < 0 || cardNum > deck.size())
            return null;
        return deck.get(cardNum);
    }
    
    /**
     * removes all cards from the deck
     */
    private void clear(){
        deck.clear();
    }
    
    /**
     * returns the number of cards in this deck
     * @return the number of cards in this deck
     */
    public int size(){
        return deck.size();
    }
    
    /**
     * sorts the deck using the Collections method for sorting, which makes
     * use of the CompareTo method implemented by Card
     * @see Card
     * @see Collections
     */
    public void sort(){
        Collections.sort(deck);
    }
    
        /**
     * Shuffles the deck using the shuffle method in the Collections class
     * @see Collections
     */
    public void shuffle(){
        Collections.shuffle(deck);
    }
    
    /**
     * converts the deck to a readable string
     * @return the cards in the deck in order as a string
     */
    @Override
    public String toString(){
        String str ="";
        for(int j=0; j<deck.size(); j++){
        str += " " + deck.get(j).toString();
        }
        return str;
    }
}
