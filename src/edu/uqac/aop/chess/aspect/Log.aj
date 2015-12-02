package edu.uqac.aop.chess.aspect;

import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.Chess;
import edu.uqac.aop.chess.agent.AiPlayer;
import edu.uqac.aop.chess.agent.HumanPlayer;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public aspect Log {

    public static final String LOG_FILE_NAME = "log.txt";

    pointcut moveMade(): call(* makeMove(..));

    after(Move mv) returning(boolean moveMade): moveMade() && args(mv) && within(AiPlayer){
        if(moveMade) {
            appendToLogFile("Ordinateur", mv);
        }
    }

    after(Move mv) returning(boolean moveMade): moveMade() && args(mv) && within(HumanPlayer){
        if(moveMade) {
            appendToLogFile("Joueur", mv);
        }
    }

    private void appendToLogFile(String playerName, Move mv){
        BufferedWriter bw = null;

        try {
            File logFile = getLogFile();
            // APPEND MODE SET HERE
            bw = new BufferedWriter(new FileWriter(logFile.getAbsolutePath(), true));
            bw.write(playerName + " : " + mv.toString());
            bw.newLine();
            bw.flush();
        } catch (IOException ioe) {
            ioe.printStackTrace();
        } finally {                       // always close the file
            if (bw != null) {
                try {
                    bw.close();
                } catch (IOException ioe2) {
                    ioe2.printStackTrace();
                }
            }
        }
    }
    pointcut startGame(): call(void play()) && within(Chess);

    before(): startGame(){
        try{
            System.out.println("Début du game");
            createNewLogFile();
        }catch(IOException e){
            e.printStackTrace();
        }
    }

    public File getLogFile() throws IOException {
        File f = new File(LOG_FILE_NAME);
        if (!f.isFile()) {
            f.createNewFile();
        }
        return f;
    }

    public void createNewLogFile() throws IOException{
        File f = new File(LOG_FILE_NAME);
        if (f.isFile()) {
            f.delete();
        }
        f.createNewFile();
    }

}