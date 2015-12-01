package edu.uqac.aop.chess.aspect;

import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.Chess;
import edu.uqac.aop.chess.agent.HumanPlayer;

public aspect Log{

    pointcut moveMade() : call(* makeMove(..)) && within(HumanPlayer);

    after(Move mv) : moveMade() && args(mv){
        File logFile = getLogFile();
        try {
			// APPEND MODE SET HERE
			bw = new BufferedWriter(new FileWriter(f.getAbsolutePath(), true));
			bw.write(mv.xI + "" + mv.yI + " en " + mv.xF + "" + mv.yF);
			bw.newLine();
			bw.flush();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		} finally {                       // always close the file
			if (bw != null) try {
			bw.close();
		} catch (IOException ioe2) {
			ioe2.printStackTrace();
		}
    }


    pointcut startGame() : call(void play()) && within(Chess);
    before() : startGame(){
        System.out.println("Début du game");
    }

    public File getLogFile(){
    	File f = new File(filePathString);
		if(!f.isFile()) { 
    		f.createNewFile();
		}
		return f;
    }

}