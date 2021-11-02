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
public interface Playable {
    /**
 * The Playable interface should be implemented by Java games such that
 * they can be included in a common file or library. The purpose of this interface
 * is to identify a few common methods that all games should have in common. A 
 * system, like a gaming counsel, emulator, or other gaming platform would be 
 * built to play things that are Playable.
 */
    /**
     * This method simply returns the title of the game.
     * @return A String representing the name of the game
     */
    public String getName();
    /**
     * This method can be used to include any directions or description that
     * a game creator feels should be accessible before starting the game. The
     * directions are returned as a String object.
     * @return The directions for the game in the form of a String
     */
    public String getDirections();
    /**
     * This method should launch the game
     */
    public void play();
}
