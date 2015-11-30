package edu.uqac.aop.chess.aspect;

import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.piece.Pawn;

/**
 * Created by Suiken on 30/11/2015.
 */
public aspect ValidateMove {

    pointcut pieceMove() : call(boolean isMoveLegal(Move));

    before(Move mv) : pieceMove() && within(Bishop) && args(mv){

    }

    before(Move mv) : pieceMove() && within(King) && args(mv){

    }

    before(Move mv) : pieceMove() && within(Knight) && args(mv){

    }

    before(Move mv) : pieceMove() && within(Pawn) && args(mv){

    }

    before(Move mv) : pieceMove() && within(Queen) && args(mv){

    }

    before(Move mv) : pieceMove() && within(Rook) && args(mv){
    }

}
