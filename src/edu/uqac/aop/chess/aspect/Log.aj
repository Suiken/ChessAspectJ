package edu.uqac.aop.chess.aspect;

import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.Chess;
import edu.uqac.aop.chess.agent.HumanPlayer;

public aspect Log{

    pointcut moveMade() : call(* makeMove(..)) && within(HumanPlayer);

    after() : moveMade(){
        System.out.println("bouge");
    }


    pointcut startGame() : call(void play()) && within(Chess);
    before() : startGame(){
        System.out.println("Début du game");
    }
}