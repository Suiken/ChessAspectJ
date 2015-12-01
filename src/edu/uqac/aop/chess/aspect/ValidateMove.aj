package edu.uqac.aop.chess.aspect;

import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.piece.Pawn;
import edu.uqac.aop.chess.piece.Bishop;
import edu.uqac.aop.chess.piece.King;
import edu.uqac.aop.chess.piece.Knight;
import edu.uqac.aop.chess.piece.Queen;
import edu.uqac.aop.chess.piece.Rook;

/**
 * Created by Suiken on 30/11/2015.
 */
public aspect ValidateMove {

    pointcut pieceMove() : execution(boolean isMoveLegal(Move));

    boolean around(Move mv) : pieceMove() && within(Rook) && args(mv){
        if(mv.xF - mv.xI == 0 || mv.yF - mv.yI == 0){
            return true;
        }
        System.out.println("Tour : mauvais placement");
        return false;
    }

    boolean around(Move mv) : pieceMove() && within(King) && args(mv){
        if(     (mv.xF - mv.xI == 1 && mv.yF - mv.yI == 1) ||
                (mv.xF - mv.xI == 1 && mv.yF - mv.yI == 0) ||
                (mv.xF - mv.xI == 1 && mv.yF - mv.yI == -1) ||
                (mv.xF - mv.xI == 0 && mv.yF - mv.yI == -1) ||
                (mv.xF - mv.xI == -1 && mv.yF - mv.yI == -1) ||
                (mv.xF - mv.xI == -1 && mv.yF - mv.yI == 0) ||
                (mv.xF - mv.xI == -1 && mv.yF - mv.yI == 1) ||
                (mv.xF - mv.xI == 0 && mv.yF - mv.yI == 1)
        ){
            return true;
        }
        System.out.println("Roi : mauvais placement");
        return false;
    }

    boolean around(Move mv) : pieceMove() && within(Knight) && args(mv){
        if(     (mv.xF - mv.xI == 2 && mv.yF - mv.yI == 1) ||
                (mv.xF - mv.xI == 2 && mv.yF - mv.yI == -1) ||
                (mv.xF - mv.xI == -2 && mv.yF - mv.yI == 1) ||
                (mv.xF - mv.xI == -2 && mv.yF - mv.yI == -1) ||
                (mv.xF - mv.xI == 1 && mv.yF - mv.yI == 2) ||
                (mv.xF - mv.xI == -1 && mv.yF - mv.yI == 2) ||
                (mv.xF - mv.xI == 1 && mv.yF - mv.yI == -2) ||
                (mv.xF - mv.xI == -1 && mv.yF - mv.yI == -2)){
            return true;
        }
        System.out.println("Cavalier : mauvais placement");
        return false;
    }

    boolean around(Move mv) : pieceMove() && within(Pawn) && args(mv){
        proceed(mv);
        if(mv.xF - mv.xI == 0 && mv.yI - mv.yF < 3){
            return true;
        }
        System.out.println("Pion : mauvais placement");
        return false;
    }

    boolean around(Move mv) : pieceMove() && within(Queen) && args(mv){
        System.out.println("Reine : mauvais placement");
        return false;
    }

    boolean around(Move mv) : pieceMove() && within(Bishop) && args(mv){
        if(mv.xF - mv.xI == mv.yF - mv.yI){
            return true;
        }
        System.out.println("Fou : mauvais placement");
        return false;
    }

}
