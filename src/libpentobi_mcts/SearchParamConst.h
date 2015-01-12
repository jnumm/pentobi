//-----------------------------------------------------------------------------
/** @file libpentobi_mcts/SearchParamConst.h
    @author Markus Enzenberger
    @copyright GNU General Public License version 3 or later */
//-----------------------------------------------------------------------------

#ifndef LIBPENTOBI_MCTS_SEARCH_PARAM_CONST_H
#define LIBPENTOBI_MCTS_SEARCH_PARAM_CONST_H

#include "Float.h"
#include "libpentobi_base/Board.h"
#include "libboardgame_mcts/PlayerMove.h"

namespace libpentobi_mcts {

using libboardgame_mcts::PlayerInt;
using libpentobi_base::Board;
using libpentobi_base::Color;

//-----------------------------------------------------------------------------

/** Optional compile-time parameters for libboardgame_mcts::Search.
    See libboardgame_mcts::SearchParamConstDefault for the meaning of the
    members. */
struct SearchParamConst
{
    typedef libpentobi_mcts::Float Float;

    static const PlayerInt max_players = 6;

    /** The maximum number of moves in a simulation.
        This needs to include pass moves because in the in-tree phase pass
        moves are used. The game ends after all colors have passed in a row.
        Therefore, the maximum number of moves is reached in case that a piece
        move is followed by (Color::range-1) pass moves and an extra
        Color::range pass moves at the end. */
    static const unsigned max_moves =
            Color::range * (Color::range * Board::max_pieces + 1);

    static const bool rave = true;

    static const bool rave_check_same = false;

    static const bool rave_dist_weighting = true;

    static const bool use_last_good_reply = true;

    static const bool virtual_loss = true;

    static const unsigned child_min_count = 3;
};

//-----------------------------------------------------------------------------

} // namespace libpentobi_mcts

#endif // LIBPENTOBI_MCTS_SEARCH_PARAM_CONST_H
