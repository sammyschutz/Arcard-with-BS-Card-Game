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
import java.util.Scanner;

/**
 * The Arcade class is meant to allow the user to navigate and play many games
 * by only launching one program
 */
public class Arcade {

    public static Scanner sc = new Scanner(System.in);

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {

        ArrayList<Playable> games = new ArrayList<Playable>();
        /*
        
            THIS IS WHERE CODE WOULD GO TO CREATE AND LOAD THE GAMES
            
         */
        BSFull bs = new BSFull();
        games.add(bs);
        for (Playable p : games) {
            System.out.println(p.getName());
            System.out.println(p.getDirections());

            System.out.println("Would you like to play this game? (Y/N)");
            char input = sc.nextLine().toUpperCase().charAt(0);
            if (input == 'Y') {
                p.play();
            }
        }
    }

}
