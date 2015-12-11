//-----------------------------------------------------------------------------
/** @file libpentobi_base/PrecompMoves.h
    @author Markus Enzenberger
    @copyright GNU General Public License version 3 or later */
//-----------------------------------------------------------------------------

#ifndef LIBPENTOBI_BASE_PRECOMP_MOVES_H
#define LIBPENTOBI_BASE_PRECOMP_MOVES_H

#include "Grid.h"
#include "Move.h"
#include "PieceMap.h"
#include "Point.h"
#include "libboardgame_util/ArrayList.h"

namespace libpentobi_base {

using libboardgame_util::ArrayList;

//-----------------------------------------------------------------------------

/** Precomputed moves for fast move generation.
    Compact storage of precomputed lists with local moves. Each list contains
    all moves that include a given point constrained by the piece type and the
    forbidden status of adjacant points. This drastically reduces the number of
    moves that need to be checked for legality during move generation.
    @see Board::get_adj_status() */
class PrecompMoves
{
public:
    /** The number of neighbors used for computing the adjacent status.
        The adjacent status is a single number that encodes the forbidden
        status of the first adj_status_nu_adj neighbors (from the list
        Geometry::get_adj() concatenated with Geometry::get_diag()). It is used
        for speeding up the matching of moves at a given point. Increasing this
        number will make the precomputed lists shorter but exponentially
        increase the number of lists and the total memory used for all lists.
        Therefore, the optimal value for speeding up the matching depends on
        the CPU cache size. */
#if PENTOBI_LOW_RESOURCES
    static const unsigned adj_status_nu_adj = 5;
#else
    static const unsigned adj_status_nu_adj = 6;
#endif

    /** The maximum sum of the sizes of all precomputed move lists in any
        game variant. */
    static const unsigned max_move_lists_sum_length =
            adj_status_nu_adj == 4 ?
                832444 : adj_status_nu_adj == 5 ? 1425934 : 2769060;
    static_assert(adj_status_nu_adj >= 4 && adj_status_nu_adj <= 6, "");

    /** The range of values for the adjacent status. */
    static const unsigned nu_adj_status = 1 << adj_status_nu_adj;

    /** Begin/end range for lists with moves at a given point. */
    struct Range
    {
        const Move* m_begin;

        const Move* m_end;

        const Move* begin() const { return m_begin; }

        const Move* end() const { return m_end; }
    };

    /** Clear storage of moves for all move lists during construction. */
    void clear() { m_move_lists.clear(); }

    /** Get number of moves in all lists. */
    unsigned get_size() const { return m_move_lists.size(); }

    /** Add move to list during construction. */
    void push_move(Move mv) { m_move_lists.push_back(mv); }

    /** Store beginning and end of a local move list duing construction. */
    void set_list_range(Point p, unsigned adj_status, Piece piece,
                        unsigned begin, unsigned size)
    {
        m_moves_range[p][adj_status][piece] = CompressedRange(begin, size);
    }

    /** Get all moves of a piece at a point constrained by the forbidden
        status of adjacent points. */
    Range get_moves(Piece piece, Point p, unsigned adj_status = 0) const
    {
        auto& range = m_moves_range[p][adj_status][piece];
        auto begin = move_lists_begin() + range.begin();
        auto end = begin + range.size();
        return Range{begin, end};
    }

    bool has_moves(Piece piece, Point p, unsigned adj_status) const
    {
        return ! m_moves_range[p][adj_status][piece].empty();
    }

    /** Begin of storage for move lists.
        Only needed for special use cases like during an in-place construction
        of PrecompMoves for follow-up positions when we need to compare the
        index of old iterators with the current get_size() to ensure that
        we don't overwrite any old content that we still need to read
        during the construction. */
    const Move* move_lists_begin() const { return &(*m_move_lists.begin()); }

private:
    class CompressedRange
    {
    public:
        CompressedRange() = default;

        CompressedRange(unsigned begin, unsigned size)
        {
            LIBBOARDGAME_ASSERT(begin < max_move_lists_sum_length);
            LIBBOARDGAME_ASSERT(begin + size <= max_move_lists_sum_length);
            static_assert(max_move_lists_sum_length < (1 << 24), "");
            LIBBOARDGAME_ASSERT(size < (1 << 8));
            m_val = size == 0 ? 0 : (begin << 8) | size;
        }

        bool empty() const { return m_val == 0; }

        unsigned begin() const { return m_val >> 8; }

        unsigned size() const { return m_val & 0xff; }

    private:
        uint_least32_t m_val;
    };

    /** See m_move_lists. */
    Grid<array<PieceMap<CompressedRange>, nu_adj_status>> m_moves_range;

    /** Compact representation of lists of moves of a piece at a point
        constrained by the forbidden status of adjacent points.
        All lists are stored in a single array; m_moves_range contains
        information about the actual begin/end indices. */
    ArrayList<Move, max_move_lists_sum_length> m_move_lists;
};

//-----------------------------------------------------------------------------

} // namespace libpentobi_base

#endif // LIBPENTOBI_BASE_PRECOMP_MOVES_H
